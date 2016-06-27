class Team < ActiveRecord::Base
    
    has_many :admin_users
    has_and_belongs_to_many :dancers
    
    def has_conflicted_dancers
        has_conflict = false
        for dancer in dancers
            if dancer.conflicted
                has_conflict = true
                break
            end
        end
        return has_conflict
    end
    
    def can_pick
        if not project
            if Team.where("project = ? AND locked = ?", true, false).length > 0
                errors.add(:pick, "not all project teams are done picking") #idk
                return false
            end
        end
        return true
    end
    
    def can_add(num)
        if self.maximum_picks == nil
            return true
        elsif self.dancers.length + num > self.maximum_picks
            return false
        else
            return true
        end
    end
    
    def toggle_lock
        if locked
            self[:locked] = false
        else
            self[:locked] = true
        end
    end
    
    def add_dancers(ids)
        added = []
        Dancer.find(Array(ids)).each do |id|
            if not id.teams.include? self
                id.teams << self
                if id.teams.length > 2
                    id.conflicted = true
                end
                id.save
            end
            added << id.name
        end
        return added
    end
    
    def remove_dancers(ids)
        removed = []
        Dancer.find(Array(ids)).each do |id|
            if id.teams.include? self
                self.dancers.delete(id)
                self.save
                id.reload
                if id.teams.length < 3
                    id.conflicted = false
                end
                id.save
                removed << id.name
            end
        end
        return removed
    end
    
    def self.project_teams_done
        if Team.where("project = ? AND locked = ?", true, false).length > 0
            return false
        else
            return true
        end
    end
    
    def self.all_teams_done
        if Team.where("locked = ?", false).length > 0
            return false
        else
            return true
        end
    end
    
    def self.final_randomization
        
        teamless_guys = []
        teamless_girls =[]

        Dancer.all.each do |dancer|
            # yolo way
            if dancer.teams.length == 0 and dancer.casting_group != nil
                if dancer.gender == "M"
                    teamless_guys << dancer
                else
                    teamless_girls << dancer
                end
            end
        end

        training_teams = []
        Team.where("project = ?", false).each do |team|
            # we can probably just set training_teams equal to this
            # didnt have time to test, dont want to break prod
            training_teams << team
        end
        
        if training_teams.length > 0
            # separate into guys / girls in an attempt to maintain 
            # an even gender ratio
            while teamless_guys.length > 0
                teamless_guys.shuffle
                training_teams.sort! { |a,b| a.dancers.length <=> b.dancers.length }
                training_teams[0].dancers << teamless_guys.shift
            end
            
            while teamless_girls.length > 0
                teamless_girls.shuffle
                training_teams.sort! { |a,b| a.dancers.length <=> b.dancers.length }
                training_teams[0].dancers << teamless_girls.shift
            end
        end
        
        training_teams.each do |team|
            team.save
        end
        
    end
    
end
