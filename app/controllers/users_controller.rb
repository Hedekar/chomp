class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      if @user.errors.any?
        self.flash[:error] = []
        for message_error in @user.errors.full_messages
          self.flash[:error] << message_error
        end
      end
      redirect_to new_user_path
    end
  end
  
  def edit
    @user = User.file(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
