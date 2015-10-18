class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
  
  def introduction
    render text: "Hello World! Testing..."
  end
=======
>>>>>>> 2f49731985e8185d7c754979207e50d5f4d414d3
end
