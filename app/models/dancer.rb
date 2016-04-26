class Dancer < ActiveRecord::Base
    
    has_and_belongs_to_many :teams
    belongs_to :casting_group
    
    validates :name, :year, :gender, :email, :phone, presence: true
    validates :email, format: { :with => /@/,
    message: "is not valid." }
    validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/,
    message: "must be in the format of XXX-XXX-XXXX." }
    
end
