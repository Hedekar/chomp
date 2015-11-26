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
  
  def main_user
    @main_user ||= User.where(:account_id => current_account.id, :is_main => 1).first if current_account
  end
  helper_method :main_user
  
  def authorize
    redirect_to login_path unless current_account
  end
  
  def check_profile
    redirect_to current_account unless main_user
  end
  
  def other_users
    @other_users ||= User.where(:account_id => current_account.id, :is_main => 0)
  end
  helper_method :other_users
  
  def todays_food_breakfast
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @food = food.get_food_list(main_user.id, now, 1)
  end
  helper_method :todays_food_breakfast

  def todays_food_lunch
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @food = food.get_food_list(main_user.id, now, 2)
  end
  helper_method :todays_food_lunch

  def todays_food_dinner
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @food = food.get_food_list(main_user.id, now, 3)
  end
  helper_method :todays_food_dinner

  def todays_food_snack
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @food = food.get_food_list(main_user.id, now, 4)
  end
  helper_method :todays_food_snack

  def todays_food_other
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @food = food.get_food_list(main_user.id, now, 5)
  end
  helper_method :todays_food_other
end
