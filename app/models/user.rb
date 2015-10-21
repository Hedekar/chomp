class User < ActiveRecord::Base
  has_secure_password
  
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i
  NAME_REGEX = /\A[A-Z ,.'-]+\z/i
  validates :email, uniqueness: true, format: EMAIL_REGEX
  validates :first_name, format: NAME_REGEX, :allow_blank => true
  validates :last_name, format: NAME_REGEX, :allow_blank => true
  
  def email=(val)
    write_attribute(:email, val.downcase)
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
end
