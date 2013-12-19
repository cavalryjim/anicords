ActiveAdmin.register Vaccination do
  filter :name
  filter :animal_type_id
  filter :created_at
  
  index do
    column :id
    column :name do |vaccination|
      link_to vaccination.name, edit_admin_vaccination_path(vaccination)
    end
    column 'day until due', :frequency
    
    column :animal_type_id
    
    default_actions
  end
  
  controller do
    def permitted_params
      params.permit!
    end
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
