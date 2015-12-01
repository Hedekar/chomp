class NutritionsController < ApplicationController
  def index
    @search_term = params[:keyword] == nil ? "" : params[:keyword]
    @search_page = params[:page].to_i
    @nutritions = Nutrition.search(@search_term, @search_page)
  end
  
  def show
    @now = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    @nutrition = Nutrition.get_detail(params[:id])
    
    @main_user = current_account.get_main_user
    @other_users = current_account.get_other_users
    
    render layout: "modal"
  end
  
  def create
    
    year = params[:date]["d(1i)"]
    month = params[:date]["d(2i)"]
    day = params[:date]["d(3i)"]
    date = year + ((month.length < 2) ? "0" + month : month) + ((day.length < 2) ? "0" + day : day )
    n = Nutrition.get_detail(params[:ndbno])
    
    error_count = 0
    params[:servings].each do |user_id, serving|
      if serving.to_f > 0.0
        food = Food.new(
          :name => params[:name],
          :serving => serving,
          :category => params[:category],
          :user_id => user_id,
          :date => date)
          
        if food.save
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
        else
          error_count = error_count + 1
        end
      end
    end
    
    if error_count == 0
      respond_to do |format|
        format.html { redirect_to :back, notice: "Food was successfully added." }
        format.json { redirect_to :show, status: :ok, location: @weight }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, :flash => { :error => 'Invalid format!' } }
        format.json { redirect_to json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end
end
