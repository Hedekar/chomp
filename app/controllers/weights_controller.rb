class WeightsController < ApplicationController
  before_filter :access_control
  before_action :set_weight, only: [:destroy]

  # GET /weights
  # GET /weights.json
  def index
    @weights = Weight.where(:user_id => params[:user_id])
  end

  # GET /weights/new
  def new
    
    @user = User.find(params[:user_id])
    current_weight = Weight.where(:user_id => params[:user_id]).order(:Date).first
    
    @weight = @user.weights.new
    
    if current_weight != nil
      @weight.Weight = current_weight.Weight
      @weight.Units = current_weight.Units
    else
      @weight.Weight = 1
      @weight.Units = "lb"
    end
    @weight.Date = Time.now.in_time_zone('Pacific Time (US & Canada)').to_date
    
  # @weight = Weight.new(:user_id => params[:user_id])
    
    
  #  current_weight = Weight.where(:user_id => current_user.id).order(:Date).first
  #  if current_weight != nil
  #    @weight.Weight = current_weight.Weight
  #    @weight.Units = current_weight.Units
  #  else
  #    @weight.Weight = 1
  #    @weight.Units = "lb"
  #  end
  #  @weight.Date = now
  #  
    render layout: "modal"
  end

  # POST /weights
  # POST /weights.json
  def create
    
    @user = User.find(params[:user_id])
    @weight = @user.weights.new(weight_params)
    
    respond_to do |format|
      if @weight.save
        format.html { redirect_to :back, notice: 'Weight was successfully updated.' }
        format.json { redirect_to :back, status: :ok, location: @weight }
      else
        format.html { redirect_to :back, :flash => { :error => 'Invalid format!' } }
        format.json { redirect_to json: @user.errors, status: :unprocessable_entity }
      end
    end
    
    #params[:weight][:user_id]=current_user.id

    #@weight = Weight.new(weight_params)
    #respond_to do |format|
    #  if @weight.save
    #    format.html { redirect_to :back, notice: 'Weight was successfully updated.' }
    #    format.json { redirect_to :show, status: :ok, location: @weight }
    #  else
    #    format.html { redirect_to :back, :flash => { :error => 'Invalid format!' } }
    #    format.json { redirect_to json: @weight.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /weights/1
  # DELETE /weights/1.json
  def destroy
    @weight.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Weight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight
      @weight = Weight.find(params[:id])
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
    def weight_params
      params.require(:weight).permit(:Weight, :Units, :Date)
    end
end