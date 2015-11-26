class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authorize
  before_filter :check_profile
  
  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end
  helper_method :current_account
  
  def authorize
    redirect_to login_path unless current_account
  end
  
  def check_profile
    redirect_to current_account unless current_account.get_main_user
  end
end
