Titleloans::Application.routes.draw do
  
  
  

  resources :companies
  
  match '/companies' => 'companies#index'
  match '/:company_id/companies' => 'companies#index', :as => :index_company
  match '/:company_id' => 'companies#show', :as => :show_company
  match '/companies/:id/edit' => 'companies#edit', :as => :edit_company
  match '/companies/new' => 'companies#new', :as => :new_company
  match '/companies/:id/destroy' => 'companies#destroy', :as => :delete_company  
  match '/:company_id/dashboard' => 'companies#dashboard', :as => :company_dashboard
  scope '/:company_id', :as => :company do 
    resources :tasks
    resources :orders
    match '/title_loans/:id/pawn_agreement' => 'title_loans#pawn_agreement', :as => :pawn_agreement
    resources :title_loans do
      resources :photos, :only => [:create, :destroy]
      resources :title_docs, :only => [:create, :destroy]
    end
    resources :customers do
      resources :addresses
    end
    resources :homes
    resources :comments
    resources :users
  end
  
  
  devise_for :users

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
  root :to => "homes#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
