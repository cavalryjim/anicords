class UserMailer < ActionMailer::Base
  default from: "no-reply@doolittl.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    #puts @user.email + " at mailer!"
    #mail to: user.email, subject: "Welcome to Doolittl"
    
    
    mail to: 'james.davisphd@gmail.com', subject: @user.email + " signed up"
    
  end
end
