require 'test_helper'

class NutrientTest < ActiveSupport::TestCase
  
  test "Empty Reference ID should not save" do
    nut = Nutrient.new
    nut.name = "Nutrient Name"
    nut.group = "Nutrient Group"
    nut.unit = "x"
    nut.value = 0.0
    assert_not nut.save
  end
  
  test "Reference ID in string value should not save" do
    nut = Nutrient.new
    nut.ref_id = "strings"
    nut.name = "Nutrient Name"
    nut.group = "Nutrient Group"
    nut.unit = "x"
    nut.value = 0.0
    assert_not nut.save
  end
  
  test "Empty Name should not save" do
    nut = Nutrient.new
    nut.ref_id = 208
    nut.group = "Nutrient Group"
    nut.unit = "x"
    nut.value = 0.0
    assert_not nut.save
  end
  
  test "Value should be greate than or equal to 0" do
    nut = Nutrient.new
    nut.ref_id = 208
    nut.name = "Nutrient Name"
    nut.group = "Nutrient Group"
    nut.unit = "x"
    
    nut.value = -1
    assert_not nut.save
    
    nut.value = 0
    assert_not_nil nut.save
    
    nut.value = 1
    assert_not_nil nut.save
    
    nut.value = 999
    assert_not_nil nut.save
  end
  
end
