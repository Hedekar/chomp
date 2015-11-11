class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authorize
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to login_path unless current_user
  end
  
  def todays_calories
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @current_calories = food.count_calories(current_user.id, now)
  end
  helper_method :todays_calories
  
  def todays_foods
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @current_breakfast = food.get_food_list(current_user.id, now, 0)
  end
  helper_method :todays_foods
  
  def current_weight
    @current_weight = ""
    weight = Weight.where(:user_id => current_user.id).order(:Date).first
    if weight != nil
      @current_weight = weight["Weight"].to_s + " " + weight["Units"]
    end
  end
  helper_method :current_weight
end
