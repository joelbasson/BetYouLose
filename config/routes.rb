Betyoulose::Application.routes.draw do

  resources :purchases, :only => [:index, :show, :destroy] do
    get 'payment_info'
  end  

  resources :payment_notifications

  match 'wagers/my_wagers' => 'wagers#my_wagers', :as => :my_wagers
  match 'bets/my_bets' => 'bets#my_bets', :as => :my_bets
  
  resources :wallets, :only => [:show] do
    get 'buy'
    post 'purchase'
    resources :transactions, :only => [:index]
  end  

  resources :bets do
    resources :wagers, :except => [:index, :show, :create, :new, :destroy]
  end  

  devise_for :users
  
  match 'bets/:bet_id/wagers/:against' => 'wagers#bet_now', :as => :bet_now
  root :to => "bets#index"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
