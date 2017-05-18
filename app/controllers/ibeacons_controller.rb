class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def index 
		@data = Ibeacon.all
	end
	
	def new
	end
	
	def create
		@infoX = beacon_params["x_motion"]
		@infoY = beacon_params["y_motion"]
		@infoZ = beacon_params["z_motion"]
# 		@info = Ibeacon.new 
# 		@info.x_motion = beacon_params["x_motion"]
# 		@info.y_motion = beacon_params["y_motion"]
# 		@info.z_motion = beacon_params["z_motion"]
# 		@info.save
		
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
