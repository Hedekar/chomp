class BmiCalcController < ApplicationController
  
  def index
  end
  
  def calculate
       @height = (params[:heightinput].to_f/100)
       @result = params[:weightinput].to_f/ (@height*@height)
       render :action => :index
  end

end
