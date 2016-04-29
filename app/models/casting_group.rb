class CastingGroup < ActiveRecord::Base
    
    attr_accessor :members
    has_many :dancers
    
    validates :video, format: { 
        with: URI.regexp,
        message: "Must enter a valid url."
    }, allow_blank: true
    
end
