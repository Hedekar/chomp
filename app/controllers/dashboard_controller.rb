class DashboardController < ApplicationController
  def show
    render layout: "blank"
  end
  
  def data_calories
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    from = now  - 2.week
    i=0
    week_calories = Array.new(14)
    until from > now
      week_calories[i] = {
        "date" => from,
        "calories" => food.count_calories(current_account.get_main_user.id, from)
      }
      i+=1
      from= from+1.day
    end
    
    respond_to do |format|
      format.json {
        render :json => week_calories
      }
    end
  end
  
  def data_weights
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date + 2.day
    from = now - 2.weeks
    weights = Weight
      .where(:Date => (from)..(now))
      .where(:user_id => current_account.get_main_user.id )
      
    
    respond_to do |format|
      format.json {
        render :json => weights
      }
    end
  end
end
