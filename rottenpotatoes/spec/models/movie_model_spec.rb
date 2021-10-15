require "rails_helper"

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe Movie, :type => :model do
    
    describe "same_director" do
        
        it "should return movies with the same director" do
            movie1 = Movie.create! :director => "Tom"
            movie2 = Movie.create! :director => "Tom"
            movie3 = Movie.create! :director => "Greg"
            expect(Movie.same_director(movie1.director)).to include(movie1, movie2)
        end
        it "should not return movies with different directors" do
            movie1 = Movie.create! :director => "Tom"
            movie2 = Movie.create! :director => "Tom"
            movie3 = Movie.create! :director => "Greg"
            expect(Movie.same_director(movie1.director)).not_to include(movie3)
        end 
    end
    
end
