class AuditionFormController < ApplicationController
    
    def index
        render 'audition_form/form'
    end
    
    def create_dancer
        name = params[:name]
        year = params[:year]
        gender = params[:gender]
        email = params[:email]
        phone = params[:phone]
        dancer = Dancer.create(:name => name, :year => year, :gender => gender, :email => email, :phone => phone)
        @audition_num = dancer.id.to_s
        render "audition_form/number"
    end
    
end