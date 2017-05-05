class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def index 
		@data = Ibeacon.all
	end
	
	def create
		@var = JSON.parse(params[:title]) if @var.present?
		
		@test = Ibeacon.create(x_motion: (params[:x_motion]))
		@test.save
		redirect_to ibeacons_path
	end
	
end
