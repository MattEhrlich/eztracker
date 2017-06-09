class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	require './lib/rep.rb'
	def index 
		# @info = Ibeacon.new 
    # Row 12
    # @info.x_motion = "468.0,437.0,671.0,578.0,906.0,562.0,218.0,640.0,531.0,234.0,640.0,546.0,234.0,531.0,593.0,328.0,781.0,453.0,140.0,687.0,625.0,671.0,"
    # @info.y_motion = "-1015.0,-921.0,-1156.0,-593.0,-1171.0,-1046.0,-296.0,-1140.0,-1109.0,-328.0,-1156.0,-1156.0,-265.0,-968.0,-1046.0,-453.0,-1125.0,-859.0,-156.0,-875.0,-625.0,-718.0,"
    # @info.z_motion = "-93.0,-15.0,-187.0,-109.0,-546.0,-203.0,390.0,-343.0,-125.0,218.0,-406.0,-375.0,265.0,-62.0,-187.0,265.0,-468.0,234.0,500.0,-296.0,-218.0,-296.0," 

    # Press 12
    # @info.x_motion = "718.0,218.0,484.0,218.0,375.0,484.0,312.0,250.0,687.0,218.0,359.0,437.0,218.0,484.0,484.0,343.0,703.0,312.0,171.0,531.0,796.0,656.0,"
    # @info.y_motion = "-453.0,562.0,1375.0,687.0,875.0,984.0,750.0,796.0,1500.0,671.0,812.0,921.0,515.0,906.0,1046.0,781.0,1265.0,531.0,609.0,171.0,-656.0,-750.0,"
    # @info.z_motion = "31.0,-46.0,187.0,0.0,156.0,171.0,109.0,109.0,187.0,62.0,93.0,93.0,-109.0,234.0,78.0,-281.0,203.0,-46.0,-203.0,156.0,-187.0,-281.0,"

    # Curl 5 
    # @info.x_motion = "703.0,1140.0,1171.0,593.0,781.0,1125.0,546.0,1031.0,921.0,1250.0,718.0,671.0,"
    # @info.y_motion = "515.0,-93.0,-93.0,453.0,343.0,-125.0,421.0,-31.0,328.0,93.0,-593.0,-718.0,"
    # @info.z_motion = "125.0,-171.0,-46.0,125.0,15.0,-156.0,109.0,-62.0,62.0,-218.0,-203.0,-281.0,"

    # Curl 7 
    # @info.x_motion = "1000.0,1062.0,875.0,1218.0,734.0,953.0,-125.0,906.0,125.0,1000.0,1046.0,937.0,1062.0,656.0,"
    # @info.y_motion = "-453.0,-31.0,15.0,-265.0,93.0,-609.0,765.0,-828.0,765.0,-750.0,-156.0,-31.0,-265.0,-765.0,"
    # @info.z_motion = "-265.0,-125.0,-31.0,-218.0,15.0,-281.0,328.0,-171.0,343.0,-328.0,-140.0,-109.0,-359.0,-250.0,"

    # Curl 9 
    # @info.x_motion = "234.0,1203.0,984.0,1078.0,1062.0,-93.0,1203.0,1062.0,640.0,1000.0,1000.0,625.0,1218.0,437.0,703.0,671.0,671.0,"
    # @info.y_motion = "625.0,-562.0,-31.0,-15.0,-625.0,703.0,-296.0,0.0,-46.0,-890.0,156.0,187.0,-500.0,250.0,-562.0,-625.0,-734.0,"
    # @info.z_motion = "171.0,-218.0,-125.0,-125.0,-250.0,328.0,-125.0,-78.0,78.0,-218.0,15.0,-31.0,-296.0,31.0,-234.0,-265.0,-281.0,"


 		# @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
 		# @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion)
 		# @info.save
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
