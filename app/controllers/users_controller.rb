class UsersController < ApplicationController
     
    def index
        @user = User.all
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
      if current_user != @user && !current_user.admin?
        flash[:danger] = 'You can only edit your own profile!'
        redirect_to root_path
      end
    end
  
    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = 'Only Admins can destroy users profile'
        redirect_to root_path
      end
    end
  
  end