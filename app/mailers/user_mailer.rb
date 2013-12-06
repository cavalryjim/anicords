class UserMailer < ActionMailer::Base
  default from: "no-reply@dooliddl.com",
          bcc: ['james.davisphd@gmail.com', 'tylercarruth@live.com']
 

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Welcome to DooLiddl"
  end
  
  def added_to_group(user_association_id)
    user_association = UserAssociation.find(user_association_id)
    @user = user_association.user
    @group = user_association.group
    mail to: @user.email, subject: "Added to DooLiddl " + user_association.group_type
  end
  
  def created_and_added_to_group(user_association_id, password)
    user_association = UserAssociation.find(user_association_id)
    @user = user_association.user
    @group = user_association.group
    @password = password
    mail to: @user.email, subject: "Welcome to DooLiddl"
  end
  
  def added_to_household(user, household) # JDavis: polymorphism will remove this
    @user = user
    @household = household
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Added to DooLiddl Household"
  end
  
  def created_and_added_to_household(user, password, household) # JDavis: polymorphism will remove this
    @user = user
    @household = household
    @password = password
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Welcome to DooLiddl"
  end
  
  def created_and_added_to_service_provider(user, password, service_provider) # JDavis: polymorphism will remove this
    @user = user
    @service_provider = service_provider
    @password = password
    mail to: user.email, subject: "Welcome to DooLiddl"
  end
  
  def added_to_service_provider(user, service_provider) # JDavis: polymorphism will remove this
    @user = user
    @service_provider = service_provider
    mail to: user.email, subject: "Added to DooLiddl Serive Provider"
  end
  
private
  
  
end
