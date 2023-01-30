class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    strong_params = [:chefname]
    devise_parameter_sanitizer.permit(:sign_up, keys: strong_params)
    devise_parameter_sanitizer.permit(:account_update, keys: strong_params)
  end
end
