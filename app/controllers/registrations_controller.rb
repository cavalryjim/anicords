class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    UserMailer.signup_confirmation(@user).deliver
    
    
    #session[:omniauth] = nil unless @user.new_record?
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
