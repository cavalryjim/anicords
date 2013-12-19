ActiveAdmin.register ServiceProvider do
  filter :name
  filter :city
  filter :state
  filter :created_at
   
  index do
    column :name
    column :email
    column :city
    column :state
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
  #  params.permit!
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
