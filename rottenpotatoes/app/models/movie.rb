class Movie < ActiveRecord::Base
    
    def self.same_director(director)
        Movie.where(director: director)
    end
    
end
