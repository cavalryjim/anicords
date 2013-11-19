ActiveAdmin.register Breed do
  filter :name
  filter :updated_at
  filter :animal_type
  
  index do
    column :id
    column :name do |breed|
      link_to breed, edit_admin_breed_path(breed)
    end
    column :animal_type
    
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
