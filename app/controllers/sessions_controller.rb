class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :check_profile
  
  def new
    render layout: "simple"
  end

  def create
    auth = Account.find_by_email(params[:email])
    if auth && auth.authenticate(params[:password])
      session[:account_id] = auth.id
      redirect_to root_path
    else
      flash.now[:error] = "Invalid email and password combination."
      params[:password] = ""
      render :new, layout: "simple"
    end
  end

  def destroy
    session[:account_id] = nil
    redirect_to root_path
  end
end
