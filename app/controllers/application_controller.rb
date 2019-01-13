class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    
    def current_user
        @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    end

    def logged_in?
        return true if current_user

        false
    end

    def require_user
        if !logged_in?
            flash[:danger] = "You must be logged in!"
            redirect_to root_path
        end
    end
end
