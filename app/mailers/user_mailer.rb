class UserMailer < ActionMailer::Base
  default from: "james@animalminder.com",
          bcc: "james.davisphd@gmail.com"
 
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Welcome to AnimalMinder"
  end
  
  def new_account_notice(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: "Welcome to AnimalMinder"
  end
  
  def added_to_group(user_association_id)
    user_association = UserAssociation.find(user_association_id)
    @user = user_association.user
    @group = user_association.group
    mail to: @user.email, subject: "Added to AnimalMinder " + user_association.group_type
  end
  
  def created_and_added_to_group(user_association_id, password)
    user_association = UserAssociation.find(user_association_id)
    @user = user_association.user
    @group = user_association.group
    @password = password
    mail to: @user.email, subject: "Welcome to AnimalMinder"
  end
  
  def added_to_household(user, household) # JDavis: polymorphism will remove this
    @user = user
    @household = household
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Added to AnimalMinder Household"
  end
  
  def created_and_added_to_household(user, password, household) # JDavis: polymorphism will remove this
    @user = user
    @household = household
    @password = password
    #puts "At user_mailer sending email"
    mail to: user.email, subject: "Welcome to AnimalMinder"
  end
  
  def created_and_added_to_service_provider(user, password, service_provider) # JDavis: polymorphism will remove this
    @user = user
    @service_provider = service_provider
    @password = password
    mail to: user.email, subject: "Welcome to AnimalMinder"
  end
  
  def added_to_service_provider(user, service_provider) # JDavis: polymorphism will remove this
    @user = user
    @service_provider = service_provider
    mail to: user.email, subject: "Added to AnimalMinder Serive Provider"
  end
  
  def animal_transfer_notice(user, animal)
    @user = user
    @animal = animal
    mail to: user.email, subject: "Health Record for " + @animal.name + " on AnimalMinder"
  end
  
  def animals_without_org_profile
    mail to: 'james.davisphd@gmail.com', subject: "AnimalMinder has animals that need org_profile!"
  end
  
  def vaccination_notice(user, animal, msg)
    @user = user
    @animal = animal
    @msg = msg
    mail to: user.email, subject: @animal.name + " is due a vaccination"
  end
  
  def orphan_associations
    mail to: 'james.davisphd@gmail.com', subject: "AnimalMinder has orphaned associations!"
  end
  
  def email_document(document, recipient)
    @recipient = recipient
    @title = document.title
    if document.animal.present?
      @animal_name = document.animal.name 
      @owner_name = document.animal.owner.name
    else 
      @animal_name = "AnimalMinder"
      @owner_name = "AnimalMinder"
    end
    file = open(URI.encode(document.file.remote_url)).read
    attachments[document.title] = file
    mail(to: recipient, subject: @animal_name + ": " + @title )
  end
  
  def weekly_usage_snapshot
    @stat = UsageStatistic.last
    mail to: ['james.davisphd@gmail.com', 'tylercarruth@live.com', 'mike@vettedcapital.com'], subject: "AnimalMinder weekly usage report"
  end
  
  def weekly_update(user_emails, group)
    #@user = user
    @group = group
    
    mail to: user_emails, subject: @group.name + "weekly snapshot"
  end
  
  def email_comment(comment)
    @comment = comment
    if @comment.comment.present?
      mailing_list = ['james.davisphd@gmail.com', 'tylercarruth@live.com', 'mike@vettedcapital.com']
      email_subject = "AnimalMinder comment"
    else
      mailing_list = 'james.davisphd@gmail.com'
      email_subject = "Joined mailing list"
    end
    mail to: mailing_list, subject: email_subject
  end
  
  def sitter_request(sitter, request, sender)
    @request = request
    @sitter = sitter
    @sender = sender
    mail to: sitter.email, subject: "Petsitter request"
  end
  
  def confirmed_sitter(sitter, request)
    @request = request
    @sitter = sitter
    mail to: sitter.email, subject: "Petsitting confirmed"
  end
  
  def non_confirmed_sitter(sitter, request)
    @request = request
    @sitter = sitter
    mail to: sitter.email, subject: "Petsitting update"
  end
  
private
  
  
end
