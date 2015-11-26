class UsersController < ApplicationController
  skip_before_filter :check_profile
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.where(:account_id => current_account.id)
  end
  
  def show
    @weights = @user.weights.limit(30)
    @foods = @user.foods.order("date DESC, category ASC").limit(30)
    render layout: "modal"
  end
  
  def new
    @user = User.new
    render layout: "modal"
  end
  
  def edit
    render layout: "modal"
  end
  
  def create
    params[:user][:account_id]=current_account.id
    
    if main_user == nil
      params[:user][:is_main]=1
    else
      params[:user][:is_main]=0
    end
    
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to current_account }
        format.json { render action: 'show', status: :created, location: current_account }
      else
        format.html { redirect_to current_account, :flash => { :error => "Invalid format!" } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to current_account }
        format.json { render action: 'show', status: :created, location: current_account }
      else
        format.html { redirect_to current_account, :flash => { :error => "Invalid format!" } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to current_account }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      unless current_account.id == @user.account_id
        flash[:danger] = "You don't have access"
        redirect_to users_path
        return
      end
    end
    
    def user_params
      params.require(:user).permit(:account_id, :is_main, :first_name, :last_name, :gender, :birth)
    end
end
