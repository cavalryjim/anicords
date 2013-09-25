Anicords::Application.routes.draw do
  
  resources :service_providers

  resources :veterinarians

  resources :households do
    resources :animals do
      resources :documents
    end
    resources :service_providers
    resources :household_associations
  end

  resources :animals do
    resources :documents
  end
  
  resources :documents

  devise_for :users, 
        path_names: {sign_in: "login", sign_out: "logout"}, 
        controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"} 
  
  resources :breeders do
    resources :animals
  end
  resources :users
  
  get 'user/select_association' => 'users#select_association'
  patch 'user/set_association' => 'users#set_association'
  patch 'households/:id/add_service_provider' => 'households#add_service_provider'
  patch 'households/:id/remove_service_provider' => 'households#remove_service_provider'
  get 'documents/:id/download_file' => 'documents#download_file'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'users#home'
  #root 'devise/registrations#new'

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
