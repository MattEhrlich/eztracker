class TrainingsController < ApplicationController
    def create
        #create a workout session
        redirect_to training_path(current_user.id)
    end
    def show
        
    end

    def update
        #add session workout results to db and delete session info
    end
end
