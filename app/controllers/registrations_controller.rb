class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    
    if Rails.env.production?
     QC.enqueue "User.signup_confirmation", @user.id
    else
      UserMailer.signup_confirmation(@user).deliver  
    end
    
  end
  
  protected

  #def after_sign_up_path_for(resource)
  #  finish_registration = root_path
  #  if params[:account_type] == "household"
  #    finish_registration = new_household_path
  #  elsif params[:account_type] == "breeder"
  #    finish_registration = new_breeder_path
  #  elsif params[:account_type] == "veterinarian"
  #    finish_registration = new_veterinarian_path
  #  end
  #  
  #  return finish_registration 
  #end
  
  
end
