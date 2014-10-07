# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_last_url
  
  def after_sign_in_path_for(resource)
    session["last_url"] || root_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
  
  def set_last_url
    blacklist = [new_user_session_path, new_user_registration_path, edit_user_password_path, new_user_password_path, user_password_path]
    unless blacklist.include? request.path
      session["last_url"] = request.path
    end
  end
  
end
