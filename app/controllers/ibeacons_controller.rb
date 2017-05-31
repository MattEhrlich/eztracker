class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	def index 
		# @info = Ibeacon.new 
		# @info.x_motion = "-15.0,-62.0,781.0,-437.0,546.0,296.0,-484.0,562.0,171.0,484.0,375.0,-546.0,375.0,-375.0,203.0,312.0,0.0,"
 	# 	@info.y_motion = "-703.0,-250.0,-406.0,0.0,-437.0,-296.0,140.0,-437.0,-140.0,-359.0,-515.0,-78.0,-453.0,234.0,-250.0,-734.0,-15.0,"
 	# 	@info.z_motion = "765.0,1015.0,828.0,343.0,1203.0,1171.0,140.0,1328.0,1296.0,1265.0,1156.0,-734.0,1250.0,812.0,1015.0,609.0,1046.0,"
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
