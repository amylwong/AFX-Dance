class AuditioneeSearchController < ApplicationController
    

    def index
        render "auditionee_search/search"
    end
    
    def search
        if params[:name]
            @dancer = Array.wrap(Dancer.find_by name: params[:name])
        else
            @dancer = Dancer.all
        end
        render "auditionee_search/results"
    end

    
    
end