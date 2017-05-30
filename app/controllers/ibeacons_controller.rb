class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	def index 
		@data = Ibeacon.all
		@result = Ibeacon.new.classify_exercise
	end
	
	def new
	end
	
	def create
		@info = Ibeacon.new 
		@info.x_motion = beacon_params["x_motion"]
 		@info.y_motion = beacon_params["y_motion"]
 		@info.z_motion = beacon_params["z_motion"]
 		@info.exercise_name = @info.classify_exercise(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
 		@info.reps_counted = @info.rep_count(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
 		@info.save
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
