class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: 'access denied!'}, status: 401
  end
  
  protected
  
   
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

  end
    
end
