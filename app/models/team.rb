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
    
    def toggle_lock
        if locked
            self[:locked] = false
        else
            self[:locked] = true
        end
    end
    
    def add_dancers(ids)
        added = []
        Dancer.find(ids).each do |id|
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
        Dancer.find(ids).each do |id|
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
    
end
