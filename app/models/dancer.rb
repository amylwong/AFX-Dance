class Dancer < ActiveRecord::Base
    has_and_belongs_to_many :teams
    belongs_to :casting_group
end