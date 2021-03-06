class Weight < ActiveRecord::Base
  belongs_to :user
  
  include ActiveModel::Validations
  
  class WeightUnit < ActiveModel::Validator
    def validate(weight)
      if weight[:Units] == "kg" or weight[:Units] == "lb"
      else
        weight.errors[:base] << "Please input 'kg' or 'lb' for units."
      end
    end
  end
  
  belongs_to :user
  default_scope -> { order(Date: :desc) }
  validates :user_id, presence: true
  validates :Weight, numericality: {greater_than_or_equal_to: 0}
  validates_with WeightUnit
  
  def get_lb 
    if self.Units == "lb"
      return self.Weight
    else
      return self.Weight*(2.20462)
    end
  end
  
end
