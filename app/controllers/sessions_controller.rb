class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Logged in"
            redirect_to welcome_home_path
        else
            flash.now[:danger] = "Something went wrong..."
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out"
        redirect_to welcome_home_path
    end
end