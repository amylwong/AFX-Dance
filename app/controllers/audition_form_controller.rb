class AuditionFormController < ApplicationController
    
    def index
        @dancer = Dancer.new
        render 'audition_form/form'
    end
    
    def create_dancer
        @dancer = Dancer.new(dancer_params)
        if @dancer.save
            @name = @dancer.name
            @audition_num = @dancer.id.to_s
            render "audition_form/number"
        else
            render "audition_form/form"
        end
    end
    
    private
    
    def dancer_params
        params.require(:dancer).permit(:name, :year, :gender, :email, :phone)
    end
        
end