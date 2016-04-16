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
    
    def self.final_randomization
        # get all dancers without a team
        # get all training teams
        # randomly assign each dancer to a training team, and then save all
        teamless = []
        # yolo way
        Dancer.all.each do |dancer|
            if dancer.teams.length == 0
                teamless << dancer
            end
        end
        
        training_teams = []
        Team.where("project = ? AND locked = ?", false, false).each do |team|
            if team.dancers.length < 15
                training_teams << team
            end
        end
        
        #WIP WIP
        
    end
    
end
