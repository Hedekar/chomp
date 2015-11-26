class CalorieCalcController < ApplicationController
  
  def index
  end
  
  def cal_metric
    
       @cal = params[:cal].to_f
       @curr_weight = params[:curr].to_f
       @targ_weight = params[:targ].to_f
       @days = params[:days].to_f

       if @targ_weight >= @curr_weight
         @result = ((@targ_weight-@curr_weight)*2.20462*3500)/@days
       else
         @result = ((@curr_weight-@targ_weight)*2.20462*3500)/@days
       end
       render :action => :index
  end
  
  def cal_imp
    
       @cal = params[:cal].to_f
       @curr_weight = params[:curr].to_f
       @targ_weight = params[:targ].to_f
       @days = params[:days].to_f

       if @targ_weight >= @curr_weight
         @res_imp = ((@targ_weight-@curr_weight)*3500)/@days
       else
         @res_imp = ((@curr_weight-@targ_weight)*3500)/@days
       end
       render :action => :index
  end
  
end
