class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	def index 
		# @info = Ibeacon.new 
		# @info.x_motion = "421.0,-593.0,-750.0,-1140.0,-1359.0,-1343.0,-640.0,-1140.0,-921.0,-718.0,-859.0,-796.0,-546.0,"
 	# 	@info.y_motion = "-640.0,-250.0,-1171.0,390.0,-1468.0,281.0,343.0,93.0,343.0,265.0,500.0,359.0,671.0,"
 	# 	@info.z_motion = "890.0,-343.0,343.0,-187.0,703.0,296.0,-406.0,-156.0,-140.0,-437.0,-265.0,-218.0,-375.0,"
 	# 	@info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
 	# 	@info.reps_counted = @info.rep_count(@info.x_motion,@info.y_motion,@info.z_motion)
 	# 	@info.save

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
