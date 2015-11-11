class DashboardController < ApplicationController
  def show
    render layout: "blank"
  end
  
  def data
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end
end
