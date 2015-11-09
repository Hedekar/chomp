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
  
  def calories_count
    @calories_count = 0
    
    calories_ref_id = 208
    list_of_foods = Food.where(:user_id => current_user.id, :date => Date.today)
    list_of_foods.each do |f| 
      
      list_of_cal = Nutrient.where(:food_id => f["id"], :ref_id => calories_ref_id)
      list_of_cal.each do |c|
        @calories_count = @calories_count + (c["value"] * f["serving"]).to_i
      end
    end
    
    return @calories_count
  end
  helper_method :calories_count
  
  def current_weight
    @current_weight = ""
    weight = Weight.where(:user_id => current_user.id).order(:Date).last
    if weight != nil
      @current_weight = weight["Weight"].to_s + " " + weight["Units"]
    end
  end
  helper_method :current_weight
  
  def get_todays_foods
    @get_todays_foods = Food.where(:user_id => current_user.id, :date => Date.today).order(:category)
  end
  helper_method :get_todays_foods
end
