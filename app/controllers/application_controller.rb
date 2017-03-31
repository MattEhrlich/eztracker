class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  def after_sign_up_path_for(resource)
    redirect_to dashboard_path(current_user)
  end
  
  
  private

end
