class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  def after_sign_in_path_for(resource)
   	ibeacons_path
  end
  
  def disable_nav
	  @disable_nav = true
  end	  

end
