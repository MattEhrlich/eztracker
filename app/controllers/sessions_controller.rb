class SessionsController < ApplicationController
    def create
        #create a workout session
        redirect_to (sessions_path(current_user), method :get)
    end
    def show
        
    end

    def update
        #add session workout results to db and delete session info
    end
end
