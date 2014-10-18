# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_last_url
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def redirect_unless_is_god
    redirect_to((session["last_url"] || root_path), alert: 'Eeeeepa! Debes ser administrador para entrar a esta sección.') unless current_user.is_god?
  end
  
  def after_sign_in_path_for(resource)
    session["last_url"] || root_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
  
  def set_last_url
    blacklist = [new_user_session_path, user_session_path, destroy_user_session_path, user_registration_path, new_user_registration_path, edit_user_password_path, new_user_password_path, user_password_path]
    unless blacklist.include?(request.path) or ['transfer_confirmed_return_osi'].include?(action_name)
      session["last_url"] = request.path
    end
  end
  
  def is_number?(object)
    true if Integer(object) rescue false
  end
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end
  
end
