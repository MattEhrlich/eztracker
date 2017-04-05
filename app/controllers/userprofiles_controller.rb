class UserprofilesController < ApplicationController
	before_action :authenticate_user! 
	
	def new
		@uprofile = Userprofile.new
	end
	
	def create
		current_user.create_userprofile!(profile_params)
		redirect_to menu_path, notice: "We've saved your profile, yeah!"
	end
	
	def edit
		@uprofile = Userprofile.find(current_user.userprofile)
	end
	
	def update
		@uprofile = Userprofile.find(current_user.userprofile)
		if @uprofile.update(profile_params)
			redirect_to menu_path, notice: "Awesome! We Updated Your Profile"
		else 
			render 'edit'
		end
	end
	
	def destroy
	end
	
	private
	
	def profile_params
		params.require(:userprofile).permit(:full_name, :age, :weight, :fitness_goal, :profile_image)
	end

end
