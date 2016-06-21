class HomepageController < ApplicationController
    def index
        redirect_to "/admin"
        #render "homepage/home"
    end
end