ActiveAdmin.register BetaComment do
  filter :comment
  filter :user
  filter :created_at
  
  index do
    column :id do |comment|
      link_to comment.id, edit_admin_beta_comment_path(comment)
    end
    column :comment
    column :page_url
    column :user
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
