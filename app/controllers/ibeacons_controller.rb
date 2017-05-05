class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def index 
		@data = Ibeacon.all
	end
	
	def create
		@test = Ibeacon.create(params[beacon_params])
		@test.save
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
