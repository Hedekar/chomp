class User < ActiveRecord::Base
  
  has_secure_password
  
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i
  validates :email, presence: true, uniqueness: true
  validates :email, format: EMAIL_REGEX
  
  def user_name
    if self.first_name == "" && self.last_name == "" then
      return "#{self.first_name} #{self.last_name}"
    else
      return "Anonymous"
    end
  end

end
