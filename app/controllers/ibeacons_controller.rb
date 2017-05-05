class IbeaconsController < ApplicationController
	
	def index 
		@data = Ibeacon.all
		@var = JSON.parse(params[:title]) if @var.present?
	end
	
end
