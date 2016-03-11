class AuditioneeProfileController < ApplicationController
    
    def index
        # require 'pry'; binding.pry
        @dancer = Dancer.find_by(id: params[:id])
        render 'auditionee_profile/profile'
    end

    
    
end