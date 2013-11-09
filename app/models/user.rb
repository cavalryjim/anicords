# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  address1               :string(255)
#  address2               :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :string(255)
#  phone                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  #include ActiveModel::Validations
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :user_associations, dependent: :destroy
  has_many  :breeders, through: :user_associations
  has_many  :households, through: :user_associations
  has_many  :veterinarians, through: :user_associations
  
  validates_presence_of :email
  #validates :email, format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , message: 'Please provide a valid e-mail address'}, if: "provider.blank?"
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, if: "provider.blank?" 
  #validates_presence_of :password, if: "provider.blank?"        
 
  def name
    if first_name || lastname
      first_name.to_s + ' ' + last_name.to_s
    else
      nil
    end
  end
  
  def name_or_email
    if first_name || last_name
      first_name.to_s + ' ' + last_name.to_s
    else
      email
    end
  end
  
  def multiple_associations?
    self.user_associations.count > 1
  end  
  
  def associations
    self.user_associations
  end
  
  def no_associations?
    self.user_associations.count == 0
  end
  
  def selected_association(association_id)
    ua = UserAssociation.find(association_id)
    if ua.breeder_id
      Breeder.find(ua.breeder_id)
    elsif ua.household_id
      Household.find(ua.household_id)
    elsif ua.veterinarian_id
      Veterinarian.find(ua.veterinarian_id)
    end
    
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    
    if user
      #user.update(auth.slice(:provider, :uid))
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      where(auth.slice(:provider, :uid)).first_or_create do |fb_user|
        fb_user.provider = auth.provider
        fb_user.uid = auth.uid
        fb_user.email = auth.info.email
      end
      user = fb_user
    end
    
    return user
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new session["devise.user_attributes"] do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def self.signup_confirmation(user_id)
    user = find(user_id)
    UserMailer.signup_confirmation(user).deliver
  end
  
  def self.added_to_household(user_id, household_id)
    user = find(user_id)
    household = Household.find(household_id)
    #puts "In model calling mailer for " + user.email
    UserMailer.added_to_household(user, household).deliver
  end
  
  def self.created_and_added_to_household(user_id, password, household_id)
    user = find(user_id)
    household = Household.find(household_id)
    #puts "In model calling mailer for " + user.email
    UserMailer.created_and_added_to_household(user, password, household).deliver
  end
  
  def self.added_to_service_provider(user_id, service_provider_id)
    user = find(user_id)
    service_provider = ServiceProvider.find(service_provider_id)
    #puts "In model calling mailer for " + user.email
    UserMailer.added_to_service_provider(user, service_provider).deliver
  end
  
  def self.created_and_added_to_service_provider(user_id, password, service_provider_id)
    user = find(user_id)
    service_provider = ServiceProvider.find(service_provider_id)
    #puts "In model calling mailer for " + user.email
    UserMailer.created_and_added_to_service_provider(user, password, service_provider).deliver
  end
  
  def create_user_to_household(email, household_id, first_name="", last_name="")
    user = User.find_by(email: email)
    household = Household.find(household_id)
    if user
      Rails.env.production? ? QC.enqueue("User.added_to_household", user.id, household_id) : UserMailer.added_to_household(user, household).deliver 
      #UserMailer.added_to_household(user, @household).deliver 
    else
      generated_password = Devise.friendly_token.first(8)
      user = User.create(email: email, password: generated_password, password_confirmation: generated_password, first_name: first_name, last_name: last_name )
      Rails.env.production? ? QC.enqueue("User.created_and_added_to_household", user.id, generated_password, household.id) : UserMailer.created_and_added_to_household(user, generated_password, household).deliver 
      #UserMailer.created_and_added_to_household(user, generated_password, @household).deliver
    end
    
    household.associate_user(user.id)
  end
  
  def self.create_user_to_service_provider(email, service_provider_id)
    user = User.find_by(email: email)
    service_provider = ServiceProvider.find(service_provider_id)
    if user
      Rails.env.production? ? QC.enqueue("User.added_to_service_provider", user.id, service_provider_id) : UserMailer.added_to_service_provider(user, service_provider).deliver 
      #UserMailer.added_to_household(user, @household).deliver 
    else
      generated_password = Devise.friendly_token.first(8)
      user = User.create(email: email, password: generated_password, password_confirmation: generated_password )
      Rails.env.production? ? QC.enqueue("User.created_and_added_to_service_provider", user.id, generated_password, service_provider.id) : UserMailer.created_and_added_to_service_provider(user, generated_password, service_provider).deliver 
      #UserMailer.created_and_added_to_household(user, generated_password, @household).deliver
    end
    
    service_provider.associate_user(user.id)
  end
  
end
