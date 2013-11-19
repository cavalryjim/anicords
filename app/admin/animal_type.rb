ActiveAdmin.register AnimalType do
  filter :name
  filter :updated_at
  
  index do
    column :id
    column :name do |at|
      link_to at, edit_admin_animal_type_path(at)
    end
    column :short_name
    
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
