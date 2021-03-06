class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:user_id]
    User.find(session[:user_id])
  end

  def authenticate_user
    redirect_to home_path unless current_user
  end

end
