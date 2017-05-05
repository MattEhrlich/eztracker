class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def index 
		@var = JSON.parse(params[:x_motion)
		render json: @var
	end
	
	def create
		@test = Ibeacon.create(params[:x_motion])
		@test.save
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
