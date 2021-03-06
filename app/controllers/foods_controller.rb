class FoodsController < ApplicationController
  before_filter :access_control
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.where(:user_id => params[:user_id])
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
  end

  # GET /foods/new
  def new
    @user = User.find(params[:user_id])
    #@food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    
    @user = User.find(params[:user_id])
    @food = @user.foods.new(food_params)
    
    #params[:food][:user_id]=current_user.id
    #@food = Food.new(food_params)
    
    respond_to do |format|
      if @food.save
        format.html { redirect_to @user, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    def access_control 
      @user = User.find(params[:user_id])
      unless current_account.id == @user.account_id
        flash[:danger] = "You don't have access"
        redirect_to users_path
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :date, :serving, :category)
    end
end
