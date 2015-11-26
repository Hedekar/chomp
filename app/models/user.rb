class User < ActiveRecord::Base
  belongs_to :account
  has_many :weights, dependent: :destroy
  has_many :foods, dependent: :destroy
  
  NAME_REGEX = /\A[A-Z ,.'-]+\z/i
  validates :account_id, presence: true
  validates :first_name, format: NAME_REGEX, :allow_blank => false
  validates :last_name, format: NAME_REGEX, :allow_blank => false
  
  def birth=(val)
    if(val.blank?)
      write_attribute(:birth, Time.now.in_time_zone('Pacific Time (US & Canada)').to_date)
    else
      write_attribute(:birth, val)
    end
  end
  
  def full_name
    if self.first_name.blank? && self.last_name.blank? then
      return "Anonymous"
    else
      return "#{self.first_name} #{self.last_name}"
    end
  end

  def gender_desc
    if self.gender == 1 then
      return "Male"
    elsif self.gender == 2 then
      return "Female"
    else
      return "Other"
    end
  end
  
  def age
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    return now.year - self.birth.year - ((now.month > self.birth.month || (now.month == self.birth.month && now.day >= self.birth.day)) ? 0 : 1)
  end
  
  def get_todays_calories
    food = Food.new()
    now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    return food.count_calories(self.id, now)
  end
  
  def get_current_weight
    weight = Weight.where(:user_id => self.id).order(:Date).first
    if weight != nil
      return weight["Weight"].to_s + " " + weight["Units"]
    else
      return "NA"
    end
  end
  
end
