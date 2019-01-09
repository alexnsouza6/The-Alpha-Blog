class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:current_user_id] = user.id
            flash[:success] = "Logged in"
            redirect_to root_path
        else
            flash.now[:danger] = "Something went wrong..."
            render 'new'
        end
    end

    def destroy
        session[:current_user_id] = nil
        flash[:success] = "Logged out"
        redirect_to root_path
    end
end