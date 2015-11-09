require 'test_helper'

class NutrientsControllerTest < ActionController::TestCase
  setup do
    @nutrient = nutrients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nutrients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nutrient" do
    assert_difference('Nutrient.count') do
      post :create, nutrient: { food_id: @nutrient.food_id, group: @nutrient.group, name: @nutrient.name, ref_id: @nutrient.ref_id, unit: @nutrient.unit, value: @nutrient.value }
    end

    assert_redirected_to nutrient_path(assigns(:nutrient))
  end

  test "should show nutrient" do
    get :show, id: @nutrient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nutrient
    assert_response :success
  end

  test "should update nutrient" do
    patch :update, id: @nutrient, nutrient: { food_id: @nutrient.food_id, group: @nutrient.group, name: @nutrient.name, ref_id: @nutrient.ref_id, unit: @nutrient.unit, value: @nutrient.value }
    assert_redirected_to nutrient_path(assigns(:nutrient))
  end

  test "should destroy nutrient" do
    assert_difference('Nutrient.count', -1) do
      delete :destroy, id: @nutrient
    end

    assert_redirected_to nutrients_path
  end
end
