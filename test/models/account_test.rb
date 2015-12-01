require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  
  test "Email should not be empty" do
    acc = Account.new
    acc.email = ""
    acc.password_digest = "1234"
    assert_not acc.save
  end
  
  test "Email should be in a correct format" do
    acc = Account.new
    acc.email = "j"
    acc.password_digest = "1234"
    assert_not acc.save
  
    acc.email = "j@"
    assert_not acc.save
    
    acc.email = "j@gmail"
    assert_not acc.save
    
    acc.email = "j@gmail."
    assert_not acc.save
    
    acc.email = "j@gmail.com"
    assert_not_nil acc.save
  end

end
