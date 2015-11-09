class Food < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :category, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :serving, numericality: {greater_than_or_equal_to: 0 }
end
