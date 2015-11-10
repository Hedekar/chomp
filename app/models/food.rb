class Food < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :category, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :serving, numericality: {greater_than_or_equal_to: 0 }
  
  def date=(val)
    if(val.blank?)
      write_attribute(:date, Date.today)
    end
  end
  
  def count_calories user_id, date
    @calories_count = 0
    calories_ref_id = 208
    list_of_foods = Food.where(:user_id => user_id, :date => date)
    list_of_foods.each do |f| 
      
      list_of_cal = Nutrient.where(:food_id => f["id"], :ref_id => calories_ref_id)
      list_of_cal.each do |c|
        @calories_count = @calories_count + (c["value"] * f["serving"]).to_i
      end
    end
    return @calories_count
  end
  
  def get_food_list user_id, date, category
    if category == 0
      @list = Food.where(:user_id => user_id, :date => date).order(:category)
    else
      @list = Food.where(:user_id => user_id, :date => date, :category => category)
    end
    return @list
  end
  
end
