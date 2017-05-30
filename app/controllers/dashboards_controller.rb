class DashboardsController < ApplicationController
	before_action :authenticate_user!
	# require './lib/recog.rb'
	# Recog.test
	def show
	end
	
	def analytics
	end
	
	def performance 
	end
end
