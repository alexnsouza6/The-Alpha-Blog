class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil # If user was deleted, reset session
  end

  def logged_in?
    return true if current_user

    false
  end

  def require_user
    return true if logged_in?

    flash[:danger] = 'You cant perform this action without login'
    redirect_to users_path
  end    
end
  
