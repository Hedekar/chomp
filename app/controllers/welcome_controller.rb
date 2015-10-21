class WelcomeController < ApplicationController
  skip_before_filter :authorize
  
  def index
    if current_user
      redirect_to home_path
    end
  end
end
