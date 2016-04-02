class Team < ActiveRecord::Base
    has_many :admin_users
    has_and_belongs_to_many :dancers
end
