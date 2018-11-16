class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Logged in"
            render 'new'
        else
            flash.now[:danger] = "Something went wrong..."
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out"
        render 'new'
    end
end