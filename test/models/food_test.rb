require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  
  test "Empty Name should not save" do
    food = Food.new
    food.date = "20151109"
    food.serving = 1.5
    food.category = 1
    assert_not food.save
  end
  
  test "Invalid Date should save todays date" do
    food = Food.new
    food.name = "John Doe"
    food.date = "WRONGDATE"
    food.serving = 1.5
    food.category = 1
    food.save
    assert food.date = Date.today
  end
  
  test "Empty Date should save todays date" do
    food = Food.new
    food.name = "John Doe"
    food.serving = 1.5
    food.category = 1
    food.save
    assert food.date = Date.today
  end
  
  test "Category should not save -1" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = -1
    assert_not food.save
  end
  
  test "Category should not save 0" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 0
    assert_not food.save
  end
  
  test "Category should save 1" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 0
    assert_not_nil food.save
  end
  
  test "Category should save 2" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 2
    assert_not_nil food.save
  end
  
  test "Category should save 3" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 3
    assert_not_nil food.save
  end
  
  test "Category should save 4" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 4
    assert_not_nil food.save
  end
  
  test "Category should save 5" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 5
    assert_not_nil food.save
  end
  
  test "Category should not save 6" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = 6
    assert_not food.save
  end
  
  test "Category should not save strings" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 1.5
    food.category = "strings"
    assert_not food.save
  end
  
  test "Serving should not save -1" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = -1
    food.category = 1
    assert_not food.save
  end
  
  test "Serving should save 0" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = 0
    food.category = 1
    assert_not_nil food.save
  end
  
  test "Serving should not save strings" do
    food = Food.new
    food.name = "John Doe"
    food.date = "20151109"
    food.serving = "strings"
    food.category = 1
    assert_not food.save
  end
  
  test "Todays foods should get foods with todays dates only" do
    food = Food.new
    list = food.get_food_list(33, 20151109, 0)
    count = 0
    list.each do |x|
      count = count + 1
    end
    assert count = 4
  end
  
  test "Todays foods (breakfast) should get foods category of 1, and with todays dates only" do
    food = Food.new
    list = food.get_food_list(33, 20151109, 1)
    count = 0
    list.each do |x|
      count = count + 1
    end
    assert count = 2
  end
  
  test "Todays foods (lunch) should get foods category of 2, and with todays dates only" do
    food = Food.new
    list = food.get_food_list(33, 20151109, 2)
    count = 0
    list.each do |x|
      count = count + 1
    end
    assert count = 2
  end
end
