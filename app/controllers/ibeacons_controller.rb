class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def index 
		@data = Ibeacon.all
		@var = JSON.parse(params[:title]) if @var.present?
		puts @var
	end
	
	def create
	end
	
end
