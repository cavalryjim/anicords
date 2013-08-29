class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    
    #JDavis: Here we need to check to see if the user has multiple associations.
    if current_user.multiple_associations?
      user_select_association_path
      
    else
      breeder_path(current_user.breeder_ids)
      
    end
  end
  
  
end
