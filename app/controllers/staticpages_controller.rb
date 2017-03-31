class StaticpagesController < ApplicationController
	
	def home
		if user_signed_in?
			redirect_to dashboard_path(current_user.id)
		end
	end
	
	def product
	end
	
	def sales
	end
	
	
	def about
	end 
		
	
end
