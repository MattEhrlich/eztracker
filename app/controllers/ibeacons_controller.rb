class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	require './lib/rep.rb'
	def index 
		@info = Ibeacon.new 
		# Curl (4)
		# @info.x_motion = "781.0,-109.0,671.0,31.0,93.0,406.0,-187.0,-171.0,15.0,"
  #       @info.y_motion = "-406.0,-187.0,-609.0,-359.0,-687.0,-671.0,-125.0,-718.0,-31.0,"
  #       @info.z_motion = "796.0,-281.0,859.0,906.0,1156.0,968.0,718.0,1203.0,1015.0,"
 		# Curl 10 ( a fast)
 		# @info.x_motion = "656.0,-15.0,281.0,812.0,140.0,125.0,687.0,578.0,265.0,-62.0,-187.0,218.0,0.0,0.0,"
   #      @info.y_motion = "-671.0,-500.0,-468.0,-781.0,-765.0,-640.0,-593.0,-578.0,-546.0,-468.0,-125.0,-312.0,0.0,0.0,"
   #      @info.z_motion = "390.0,-1703.0,-812.0,1546.0,1625.0,1562.0,1578.0,1234.0,1281.0,1046.0,-1437.0,578.0,1000.0,1015.0,"

 		# Curl 8 
 		# @info.x_motion = "-15.0,-62.0,781.0,-437.0,546.0,296.0,-484.0,562.0,171.0,484.0,375.0,-546.0,375.0,-375.0,203.0,312.0,0.0,"
   #      @info.y_motion = "-703.0,-250.0,-406.0,0.0,-437.0,-296.0,140.0,-437.0,-140.0,-359.0,-515.0,-78.0,-453.0,234.0,-250.0,-734.0,-15.0,"
   #      @info.z_motion = "765.0,1015.0,828.0,343.0,1203.0,1171.0,140.0,1328.0,1296.0,1265.0,1156.0,-734.0,1250.0,812.0,1015.0,609.0,1046.0,"


        # press 8
        # @info.x_motion = "15.0,-1015.0,-468.0,-484.0,-750.0,-531.0,-62.0,-781.0,-250.0,-250.0,-484.0,-125.0,-312.0,46.0,0.0,"
        # @info.y_motion = "-875.0,718.0,390.0,46.0,1265.0,843.0,390.0,984.0,906.0,593.0,1031.0,390.0,734.0,500.0,0.0,"
        # @info.z_motion = "1250.0,-546.0,-46.0,-156.0,-375.0,-343.0,-218.0,-406.0,-312.0,-234.0,-406.0,-234.0,-218.0,-265.0,1015.0,"

        # press 8 (again)
        # @info.x_motion = "-453.0,-140.0,-890.0,-484.0,-578.0,-437.0,-1234.0,-406.0,-406.0,-453.0,-515.0,-406.0,-531.0,-390.0,-625.0,-109.0,-703.0,-500.0,-375.0,31.0,"
        # @info.y_motion = "-812.0,-671.0,906.0,484.0,1000.0,750.0,1000.0,234.0,906.0,718.0,859.0,671.0,812.0,609.0,1078.0,859.0,968.0,750.0,390.0,-31.0,"
        # @info.z_motion = "687.0,953.0,-531.0,-312.0,-203.0,-156.0,312.0,-281.0,-125.0,-265.0,78.0,-46.0,-203.0,-140.0,-156.0,-187.0,-156.0,-406.0,640.0,1031.0,"


 		@info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
 		@info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion)
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
 		@info.reps_counted = Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
 		@info.save
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
