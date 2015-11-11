require 'test_helper'

class WeightTest < ActiveSupport::TestCase
  
  test "weight unit should be kg or lb" do
    weight = Weight.new
    weight.Weight = 160
    weight.Units = "xx"
    weight.Date = "2015-11-07 00:00:00"
    assert_not weight.save
  end
  
end
