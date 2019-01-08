class UsersController < ApplicationController


    def index
        @user = User.all
        render "index"
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome, #{@user.username}"
            redirect_to welcome_home_path
        else
            render 'new'
        end

    def update
        @user = User.find(params[:id])
            if @user.update(user_params)
              flash[:success] = 'Your account was successfully updated'
              redirect_to articles_path
            else
              render 'edit'
            end
          end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = 'User was deleted successfully'
        redirect_to users_path
    end

    def edit
        @user = User.find(params[:id])
    end

    private 
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
    
end