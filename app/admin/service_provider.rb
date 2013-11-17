ActiveAdmin.register ServiceProvider do
  filter :name
  filter :city
  filter :state
  filter :created_at
   
  index do
    column :service_provider do |provider|
      link_to provider, edit_admin_service_provider_path(provider)
    end
    column :email
    column :city
    column :state
    default_actions
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
