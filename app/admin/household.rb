ActiveAdmin.register Household do
  filter :name
  filter :city
  filter :state
  filter :created_at
  
  index do
    column :id
    column :name do |household|
      link_to household, edit_admin_household_path(household)
    end
    
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
