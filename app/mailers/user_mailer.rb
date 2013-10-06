class UserMailer < ActionMailer::Base
  default from: "no-reply@doolittl.com",
          bcc: ['james.davisphd@gmail.com', 'tylercarruth@live.com']
 

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Welcome to DooLittl"
  end
  
  def added_to_household(user, household)
    @user = user
    @household = household
    puts "At user_mailer sending email"
    mail to: user.email, subject: "Added to DooLiddl Household"
  end
  
  def created_and_added_to_household(user, password, household)
    @user = user
    @household = household
    @password = password
    puts "At user_mailer sending email"
    mail to: user.email, subject: "Welcome to DooLiddl"
  end
  
private
  
  
end
