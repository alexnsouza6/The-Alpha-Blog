class UsersController < ApplicationController
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def index
        @users = User.all
        render "index"
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome to Alpha Blog, #{@user.username}"
        redirect_to user_path(@user)
      else
        render 'new'
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = 'Your account was successfully updated'
      else
        render 'edit'
      end
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = 'User was deleted successfully'
      redirect_to users_path
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        @user = User.find(params[:id])
        if current_user != @user and !current_user.admin?
            flash[:danger] = "You can only edit your own account"
            redirect_to root_path
        end
    end  
end
  