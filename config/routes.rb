Rails.application.routes.draw do
  
  get 'calorie_calc/index'
  
  resources :calorie_calc do
    collection do
      post 'cal_metric'
      post 'cal_imp'
    end
  end

  resources :accounts
  resources :users do
    resources :weights
    resources :foods
  end
  resources :nutrients
  resources :nutritions
  
  get 'bmi_calc/index'
  
  resources :bmi_calc do
    collection do
      post 'bmi_metric'
      post 'bmi_imp'
    end
  end
  
  controller :dashboard do
    get 'home' => :index
    get 'track' => :show
    get 'data', :defaults => { :format => 'json' }
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  #controller :users do
  #  get 'edit_account' => :edit_account
  #  post 'edit_account' => :update_acccount
  #  get 'edit_profile' => :edit_profile
  #  post 'edit_profile' => :update_profile
  #end

  root 'dashboard#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
