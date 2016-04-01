class Dancer < ActiveRecord::Base
    
    has_and_belongs_to_many :teams
    belongs_to :casting_group
    
    validates :name, :year, :gender, :email, :phone, presence: true
    validates :year, inclusion: { in: %w(1 2 3 4 Other),
    message: "must be 1, 2, 3, 4, or Other." }
    validates :gender, inclusion: { in: %w(Male Female),
    message: "must be Male or Female." }
    validates :email, format: { :with => /@/,
    message: "is not valid." }
    validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/,
    message: "must be in the format of XXX-XXX-XXXX." }
    
end
