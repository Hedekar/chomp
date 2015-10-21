class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end

  def create
    auth_user = User.find_by_email(params[:email])
    if auth_user && auth_user.authenticate(params[:password])
      session[:user_id] = auth_user.id
      redirect_to root_path
    else
      flash[:error] = "Invalid email and password combination."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end
end
