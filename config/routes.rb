MetabraneCo::Application.routes.draw do
 #  get "weaves/create"
  resources :personas do
    collection do
      post 'login'
      get 'logout'
    end
  end


  #match 'about/' => 'welcome#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  match 'resonance_core/get_entry_point' => 'resonance_core#get_entry_point'
  match 'resonance_core/bind' => 'resonance_core#bind'
  match 'resonance_core/highscore' => 'resonance_core#highscore'
  
  resources :substrates do
    member do 
      put "update_metacode"
      get "zoom"
    end
  end
  
  resources :weaves do
    member do
      post 'favorite'
      get 'preview'
      get 'image'
    end
    
    collection do
      get 'favorites'
      get 'random'
      get 'search'
    end
  end

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  match 'welcome' => 'welcome#index'

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  match '/' => redirect('/weaves')

  # You can have the root of your site routed with "root"
  #root :to => "welcome#index"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end
