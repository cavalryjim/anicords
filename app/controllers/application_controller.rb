class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 
  protect_from_forgery with: :exception
  #JDavis: this is a work-around for a Rails 4 and Cancan.
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    elsif current_user     
      #JDavis: Here we need to check to see if the user has multiple associations.
      if current_user.multiple_associations?
        session[:home_page] = user_select_association_path
      elsif current_user.user_association_ids.count == 1
        session[:home_page] = url_for(current_user.selected_association(current_user.user_association_ids.first))  
      elsif current_user.no_associations?
        user_select_account_type_path
      else
        session[:home_page] = user_path(current_user)
      end
    end
  end
  
  
 private
  
end
