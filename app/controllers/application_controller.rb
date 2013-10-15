class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def after_sign_in_path_for(resource)
    
    #JDavis: Here we need to check to see if the user has multiple associations.
    if current_user.multiple_associations?
      user_select_association_path
      
    elsif current_user.user_association_ids.count == 1
      session[:home_page] = url_for(current_user.selected_association(current_user.user_association_ids.first))
      #breeder_path(current_user.breeder_ids.first)
      #session[:home_page]
    elsif current_user.no_associations?
      user_select_account_type_path
    else
      # JDavis: Will need to prompt the user for setting up a household, breeder, or veterinarian account
      #     Something like 'They are part of our homes so let's add them as a household account'.
      session[:home_page] = user_path(current_user)
    end
  end
  
  
  
 private
  
end
