ActiveAdmin.register AdminUser do
  index do
    column :email do |admin_user|
      link_to admin_user.email, edit_admin_admin_user_path(admin_user)
    end
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit admin_user: [:email, :password, :password_confirmation]
    end
  end
end
