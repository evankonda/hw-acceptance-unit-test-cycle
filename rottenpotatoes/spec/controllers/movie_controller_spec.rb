require 'rails_helper'

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

RSpec.describe MoviesController, :type => :controller do
    
    describe "director" do
        
        it "should show all movies made by the same director" do
            @movie = Movie.create({:id => 12, :title => "Apple", :rating => "G", :director => "Tom", :release_date => "2021-10-10"})
            get :director, :id => @movie.id
            expect(response).to render_template :director
        end
        
        it "should return the user to the index page" do
            @movie = Movie.create(:id => 13, :title => "Apple", :rating => "G", :director => '', :release_date => "2021-10-10")
            get :director, :id => @movie.id
            expect(response).to redirect_to movies_path
        end
        
    end 
    
end