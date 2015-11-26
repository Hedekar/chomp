class BmiCalcController < ApplicationController
  
  def index
  end
  
  def bmi_metric
       @height = (params[:heightinput].to_f/100)
       @result = params[:weightinput].to_f/ (@height*@height)
       render :action => :index
  end
  
  def bmi_imp
       @heightimp = (params[:heightfeet].to_f*12)+(params[:heightinch].to_f)
       @imp = (params[:weightlb].to_f/ (@heightimp*@heightimp))*703
       render :action => :index
  end

end
