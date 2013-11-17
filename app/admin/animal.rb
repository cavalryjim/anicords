ActiveAdmin.register Animal do
  filter :name
  filter :household
  filter :breed
  filter :created_at
  
  index do
    column :id
    column :name do |animal|
      link_to animal, edit_admin_animal_path(animal)
    end
    column :household
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
