class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @users = User.all
  end
  
  def show
    @user = current_user
  end
  
  def new
    @user = User.new()
  end
  
  def create
    @user = User.new(user_account_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successfully registered"
      redirect_to edit_user_path(@user)
    else
      if @user.errors.any?
        flash.now[:error] = []
        for message_error in @user.errors.full_messages
          flash.now[:error] << message_error
        end
      end
      render "new"
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_profile_params)
      flash[:notice] = "Successfully updated"
      redirect_to current_user
    else
      if @user.errors.any?
        flash.now[:error] = []
        for message_error in @user.errors.full_messages
          flash.now[:error] << message_error
        end
      end
      render "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birth)
  end
  
  def user_account_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
