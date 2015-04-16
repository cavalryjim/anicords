Anicords::Application.routes.draw do
  

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :service_providers do
    member do
      get 'public_view'
      get 'client_list'
    end
    resources :animals do
      member do
        get 'check_in'
        get 'check_out'
      end
    end
  end

  resources :veterinarians
  resources :agencies do
    member do
      get 'welcome'
    end
  end
  resources :organizations do
    resources :user_associations
    resources :animals
    resources :locations
    member do
      post 'import_animals'
      post 'vaccinations_report'
      get 'vaccinations_report'
    end
  end

  resources :households do
    member do
      get 'schedule_sitter', as: :schedule_sitter
    end
    resources :animals do
      resources :pictures
      resources :documents
      resources :animal_vaccinations
    end
    resources :service_providers
    resources :household_associations
    resources :user_associations
    resources :sitter_requests do
      member do
        get 'sitter_response'
        get 'confirm_sitter'
      end
    end
    
  end

  resources :animals do
    resources :pictures
    resources :documents
    resources :animal_vaccinations
    resources :animal_medications
    resources :animal_associations
    resources :org_profiles
    resources :weights
  end
  
  #resources :documents
  #resources :pictures

  devise_for :users, 
  #ActiveAdmin.routes(self)
        path_names: {sign_in: "login", sign_out: "logout", sign_up: "welcome"}, 
        controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"} 
  
  resources :breeders do
    resources :animals
  end
  resources :users do
    resources :user_associations
  end
  
  resources :user_associations
  resources :animal_vaccinations
  #resources :activities
  resources :beta_comments
  resources :animal_associations
  resources :notifications
  
  post 'documents/:id/email_document' => 'documents#email', as: :email_document
  post 'animals/microchip_lookup' => 'animals#microchip_lookup', as: :microchip_lookup
  get 'privacy_policy' => "pages#privacy_policy", as: :privacy_policy
  get 'about' => "pages#about", as: :about_us
  get 'contact' => "pages#contact", as: :contact_us
  get 'learn_more' => "pages#learn_more", as: :learn_more
  get 'news' => "pages#news", as: :news
  get 'features' => "pages#features", as: :features
  get 'user/select_association' => 'users#select_association'
  patch 'user/set_association' => 'users#set_association'
  get 'user/select_account_type' => 'users#select_account_type'
  patch 'households/:id/add_service_provider' => 'households#add_service_provider'
  patch 'households/:id/remove_service_provider' => 'households#remove_service_provider'
  get 'documents/:id/download_file' => 'documents#download_file'
  post 'households/:id/create_user' => 'households#create_user'
  get 'households/:id/external_view' => 'households#external_view', as: :household_external_view
  post 'organizations/:id/create_user' => 'organizations#create_user'
  get 'organizations/:id/petfinder_import' => 'organizations#petfinder_import', as: :organizaiton_petfinder_import
  get 'organizations/:id/adoptions' => 'organizations#adoptions', as: :organizaiton_adoptions
  get 'organizations/:id/new_foster' => 'organizations#new_foster', as: :new_organization_foster
  patch 'organizations/:id/new_foster' => 'organizations#create_foster', as: :create_organization_foster
  patch 'organizations/:id/new_foster_user' => 'organizations#new_foster_user', as: :new_foster_user
  patch 'organizations/:id/new_foster_home' => 'organizations#new_foster_home', as: :new_foster_home
  patch 'organizations/:id/select_foster_home' => 'organizations#select_foster_home', as: :select_foster_home
  delete 'organizations/:organization_id/organization_locations/:id/destroy' => 'organization_locations#destroy', as: :remove_organization_location
  #get 'service_providers/:id/services' => 'service_providers#services'
  get 'animals/:id/download_file' => 'animals#download_file'
  #get '/animals/:id/weight_chart' => 'animals#weight_chart'
  patch 'animals/:id/transfer_ownership' => 'animals#transfer_ownership', as: :transfer_animal
  patch 'animals/:id/accept_transfer' => 'animals#accept_transfer', as: :accept_transfer
  get 'animals/:id/cancel_transfer' => 'animals#cancel_transfer', as: :cancel_transfer
  get 'animals/:id/sitter_instructions' => 'animals#sitter_instructions', as: :animal_sitter_instructions
  get 'animals/:id/dog_facts' => 'animals#dog_facts', as: :animal_dog_facts
  post 'animals/:id/contact_owner' => 'animals#contact_owner', as: :contact_owner
  get 'organizations/:organization_id/animals/:id/org_flyer' => 'animals#org_flyer', as: :organization_animal_flyer
  match 'animals/:id/photo_gallery' => 'animals#photo_gallery', via: [:get, :post], as: :animal_photo_gallery
  patch 'pictures/:id/crop' => 'pictures#crop'
  #get 'service_providers/:id/public_view' => 'service_providers#public_view', as: :service_provider_public_view
  #get 'service_providers/:id/client_list' => 'service_providers#client_list', as: :service_provider_client_list
  
  get 'remote_requests/vitamins' => 'remote_requests#vitamins'
  get 'remote_requests/allergies' => 'remote_requests#allergies'
  get 'remote_requests/foods' => 'remote_requests#foods'
  get 'remote_requests/medical_diagnoses' => 'remote_requests#medical_diagnoses'
  get 'remote_requests/shampoos' => 'remote_requests#shampoos'
  get 'remote_requests/treats' => 'remote_requests#treats'
  get 'remote_requests/medications' => 'remote_requests#medications'
  get 'remote_requests/services' => 'remote_requests#services'
  get 'remote_requests/vaccinations' => 'remote_requests#vaccinations'
  get 'remote_requests/breeds' => 'remote_requests#breeds'
  get 'remote_requests/registration_clubs' => 'remote_requests#registration_clubs'
  get 'remote_requests/personality_types' => 'remote_requests#personality_types'
  

  get "animal_medications/create"
  get "animal_medications/destroy"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # match '', to: 'agency#welcome', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }, via: :all
  get '', to: 'agencies#welcome', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
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
