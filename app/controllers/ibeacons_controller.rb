class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	def index 
		# @info = Ibeacon.new 
		# @info.x_motion = "-78.0,843.0,-578.0,218.0,406.0,-484.0,625.0,-515.0,500.0,-437.0,500.0,-328.0,468.0,-453.0,500.0,140.0,234.0,93.0,265.0,109.0,156.0,-187.0,62.0,15.0,"
 	# 	@info.y_motion = "-437.0,-546.0,234.0,-421.0,-765.0,265.0,-734.0,234.0,-718.0,281.0,-687.0,15.0,-734.0,109.0,-531.0,-265.0,-343.0,-437.0,-453.0,-281.0,-281.0,375.0,-31.0,-31.0,"
 	# 	@info.z_motion = "781.0,1250.0,-343.0,1250.0,1031.0,453.0,921.0,140.0,718.0,906.0,1078.0,937.0,1171.0,312.0,1031.0,1109.0,1046.0,781.0,1062.0,1062.0,1000.0,78.0,765.0,1015.0,"
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
