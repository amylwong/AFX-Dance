class Team < ActiveRecord::Base
    
    has_many :admin_users
    has_and_belongs_to_many :dancers
    
    # checks if the team currently has conflicted dancers
    def has_conflicted_dancers
        # is there a way to find this via CollectionProxy actions??
        has_conflict = false
        for dancer in dancers
            if dancer.conflicted
                has_conflict = true
                break
            end
        end
        return has_conflict
    end
    
    # checks if the team can currently pick
    def can_pick
        if not project
            # training teams can only pick after project teams are done picking
            if Team.where(project: true, locked: false).count > 0
                errors.add(:pick, "not all project teams are done picking")
                return false
            end
        end
        return true
    end
    
    # checks if the team can add `num` number of picks
    def can_add(num)
        if self.maximum_picks == nil
            return true
        elsif self.dancers.length + num > self.maximum_picks
            return false
        else
            return true
        end
    end
    
    # toggles lock between true and false
    def toggle_lock
        if locked
            self[:locked] = false
        else
            self[:locked] = true
        end
    end
    
    # helper function to add dancers to a team
    def add_dancers(ids)
        # keeping this iteratively so we are able to return
        # the list of added dancers - will revisit
        # (this gives me cancer)
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
    
    # helper function to remove dancers from a team
    def remove_dancers(ids)
        # keeping this iteratively so we are able to return
        # the list of removed dancers - will revisit
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
    
    # returns true if all project teams are locked
    def self.project_teams_done
        if Team.where(project: true, locked: false).count > 0
            return false
        else
            return true
        end
    end
    
    # returns true if all teams are locked
    def self.all_teams_done
        if Team.where(locked: false).count > 0
            return false
        else
            return true
        end
    end
    
    def self.final_randomization
        
        # fetch arrays of teamless guys and teamless girls
        teamless_guys = Dancer.joins(:teams).group('dancers.id').having('count(dancer_id) = ? AND gender = ?', 0, "M").to_ary
        teamless_girls = Dancer.joins(:teams).group('dancers.id').having('count(dancer_id) = ? AND gender = ?', 0, "F").to_ary
        
        # fetch arrays of teamless dancers by querying for any dancer with zero teams
        teamless_dancers = Dancer.joins(:teams).group('dancers.id').having('count(dancer_id) = ?', 0).to_ary
        
        # fetch all training teams
        training_teams = Team.where(project: false)
        
        if training_teams.length > 0
            # previously, we were separating guys / girls in an attempt to maintain an
            # even gender ratio - however, this would result in 'frontloading' either gender:
            # we'll use a truly random method for now, until finding something better
            
            while teamless_dancers.length > 0
                # randomize dancers each time
                teamless_dancers.shuffle
                # sort training teams so we add to the one with least people
                training_teams.sort! { |a,b| a.dancers.length <=> b.dancers.length }
                training_teams[0].dancers << teamless_dancers.shift
            end
        end
        
        # save all the training teams
        training_teams.each do |team|
            team.save
        end
        
    end
    
end
