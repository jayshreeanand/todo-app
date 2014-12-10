class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_time_zone  


  def set_time_zone
    Time.zone = current_user.time_zone if current_user
  end

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :time_zone
  end


end
