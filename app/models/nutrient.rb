class Nutrient < ActiveRecord::Base
  belongs_to :food
  validates :ref_id, presence: true, numericality: true
  validates :name, presence: true
  validates :value, numericality: {greater_than_or_equal_to: 0 }
end
