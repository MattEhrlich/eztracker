class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	def index 

		@info = Ibeacon.new 
		@info.x_motion = "-453.0,-140.0,-890.0,-484.0,-578.0,-437.0,-1234.0,-406.0,-406.0,-453.0,-515.0,-406.0,-531.0,-390.0,-625.0,-109.0,-703.0,-500.0,-375.0,31.0,"
 		@info.y_motion = "-812.0,-671.0,906.0,484.0,1000.0,750.0,1000.0,234.0,906.0,718.0,859.0,671.0,812.0,609.0,1078.0,859.0,968.0,750.0,390.0,-31.0,"
 		@info.z_motion = "687.0,953.0,-531.0,-312.0,-203.0,-156.0,312.0,-281.0,-125.0,-265.0,78.0,-46.0,-203.0,-140.0,-156.0,-187.0,-156.0,-406.0,640.0,1031.0,"
 		@info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
 		@info.reps_counted = @info.rep_count(@info.x_motion,@info.y_motion,@info.z_motion)
 		@info.save
 	
		@data = Ibeacon.all
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
