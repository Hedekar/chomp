class NutritionsController < ApplicationController
  def index
    @search_term = params[:keyword]
    @search_page = params[:page].to_i
    @nutritions = Nutrition.search(@search_term, @search_page)
  end
  
  def show
    @now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @nutrition = Nutrition.get_detail(params[:id])
    render layout: "modal"
  end
  
  def create
    
    year = params[:date]["d(1i)"]
    month = params[:date]["d(2i)"]
    day = params[:date]["d(3i)"]
    date = year + ((month.length < 2) ? "0" + month : month) + ((day.length < 2) ? "0" + day : day )
    
    food = Food.new(params.permit(:name, :serving, :category))
    food.user_id = current_user.id
    food.date = date
    food.save
    
    n = Nutrition.get_detail(params[:ndbno])
    n["report"]["food"]["nutrients"].each do |x|
      nutrient = Nutrient.new()
      nutrient.ref_id = x["nutrient_id"]
      nutrient.name = x["name"]
      nutrient.group = x["group"]
      nutrient.unit = x["unit"]
      nutrient.value = x["value"]
      nutrient.food_id = food.id
      nutrient.save
    end
  end
end
