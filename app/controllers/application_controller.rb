class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  #Handle 500 Excess Denied Error 
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :email)
    end
  end

end
