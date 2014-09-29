class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
   
    if user.present? && user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      session["devise.user_attributes"] = user.attributes if (user.attributes.present?)
      redirect_to new_user_registration_url, alert: "Sorry but we are unable to authenticate you through Facebook"
    end
  end
  
  alias_method :twitter, :all
  alias_method :facebook, :all

end
