class Account < ActiveRecord::Base
  has_secure_password
  has_many :users, dependent: :destroy
  
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i
  validates :email, uniqueness: true, format: EMAIL_REGEX
  
  def email=(val)
    write_attribute(:email, val.downcase)
  end
  
  def get_users
    return User.where(:account_id => self.id).order("is_main DESC, first_name ASC, last_name ASC")
  end
  
  def get_main_user
    return User.where(:account_id => self.id, :is_main => 1).first
  end
  
  def get_other_users
    return User.where(:account_id => self.id, :is_main => 0).order("first_name ASC, last_name ASC")
  end
end
