class DancerController < ApplicationController
    
    def index
        @dancers = Dancer.all
        render 'dancer/list'
    end
    
    def random_assignment
        @dancers = Dancer.all
        @teams = Team.all
        @dancers.each do |dancer|
            if dancer.teams.empty?
                dancer.teams << @teams.sort_by {|team| team.dancers.count}[0] 
            end
        end
    end
    
end