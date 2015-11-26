class Account < ActiveRecord::Base
  has_secure_password
  has_many :users, dependent: :destroy
  
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i
  validates :email, uniqueness: true, format: EMAIL_REGEX
  
  def email=(val)
    write_attribute(:email, val.downcase)
  end
end
