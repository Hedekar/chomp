require 'test_helper'

class WeightTest < ActiveSupport::TestCase
  
  test "weight unit should be kg or lb" do
    weight = Weight.new
    weight.Weight = 160
    weight.Units = "xx"
    weight.Date = "2015-11-07 00:00:00"
    assert_not weight.save
    
    weight.Units = "lb"
    assert_not_nil weight.save
    
    weight.Units = "kb"
    assert_not_nil weight.save
  end
  
  test "weight should be greater than or eqaul to zero" do
    weight = Weight.new
    weight.Units = "lb"
    weight.Date = "2015-11-07 00:00:00"
    weight.Weight = -1
    assert_not weight.save
    
    weight.Weight = 0
    assert_not_nil weight.save
    
    weight.Weight = 1
    assert_not_nil weight.save
  end

  
end
