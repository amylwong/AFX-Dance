class CastingGroup < ActiveRecord::Base
    has_many :dancers
    
    validates :video, format: { 
        with: URI.regexp,
        message: "Must enter a valid url."
    }, allow_blank: false
    
end
