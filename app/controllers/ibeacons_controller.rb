class IbeaconsController < ApplicationController
	
	def index 
		@data = Ibeacon.all
		@var = JSON.parse(params[:title]) if @var.present?
		puts @var
	end
	
end
