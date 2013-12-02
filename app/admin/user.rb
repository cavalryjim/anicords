ActiveAdmin.register User do
  filter :first_name
  filter :last_name
  filter :email
  filter :created_at
  
  index do
    column :id
    column :name do |user|
      link_to user.name_or_email, edit_admin_user_path(user)
    end
    column :email do |user|
      link_to user.email, edit_admin_user_path(user)
    end
    
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
