class ApplicationController < ActionController::Base
  #include PublicActivity::StoreController 
  protect_from_forgery with: :exception
  #JDavis: this is a work-around for a Rails 4 and Cancan.
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
  before_filter :check_for_subdomain
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    if current_user.present?
      redirect_to user_select_association_path
    else
      redirect_to home_path
    end
  end
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    elsif current_user     
      #JDavis: Here we need to check to see if the user has multiple associations.
      session[:home_page] = user_select_association_path
      
      if current_user.multiple_associations?
        user_select_association_path 
      elsif current_user.no_associations?
        user_select_account_type_path
      else
        current_user.user_associations.first.group 
      end
    end
  end
  
  
 private
  def check_for_subdomain
    if request.subdomain.present? && (request.subdomain != 'www')
      #puts 'subdomain is ' + request.subdomain
      @agency = Agency.find_by_subdomain!(request.subdomain)
    end
  end
  
end
