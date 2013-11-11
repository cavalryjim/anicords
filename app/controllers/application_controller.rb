class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery with: :exception
  
  
  def after_sign_in_path_for(resource)
    
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
  
  
  
 private
  
end
