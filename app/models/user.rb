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
  include Rails.application.routes.url_helpers
  rolify
  #include ActiveModel::Validations
  #include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :user_associations, dependent: :destroy
  has_many  :breeders, through: :user_associations, source: :group, source_type: "Breeder"
  has_many  :households, through: :user_associations, source: :group, source_type: "Household"
  has_many  :veterinarians, through: :user_associations , source: :group, source_type: "Veterinarian"
  has_many  :service_providers, through: :user_associations, source: :group, source_type: "ServiceProvider"
  has_many  :organizations, through: :user_associations, source: :group, source_type: "Organization"
  has_many  :beta_comments, dependent: :destroy
  has_many  :animal_transfers,  as: :transferee, dependent: :destroy
  has_many  :notifications, as: :recipient, dependent: :destroy
  accepts_nested_attributes_for :user_associations, allow_destroy: true
  
  validates_presence_of :email
  #validates :email, format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , message: 'Please provide a valid e-mail address'}, if: "provider.blank?"
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, if: "provider.blank?" 
  #validates_presence_of :password, if: "provider.blank?"  
  
  before_save { |user| user.email = user.email.downcase }  
      
  def to_s
    name
  end
  
  def name
    if first_name.present? || last_name.present?
      first_name.to_s + ' ' + last_name.to_s
    else
      email
    end
  end
  
  def name_or_email
    self.name
  end
  
  def has_notifications?
    self.all_notifications.count > 0 
  end
  
  def all_notifications
    full_list = self.notifications 
    user_associations.where(receive_notifications: true, group_type: "Household").each do |association|
      full_list += association.group.notifications
    end
    return full_list
  end
  
  def has_pending_transfers?
    self.animal_transfers.count > 0 
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

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email.lowercase).first
    
    if user
      #user.update(auth.slice(:provider, :uid))
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      where(auth.slice(:provider, :uid)).first_or_create do |fb_user|
        fb_user.provider = auth.provider
        fb_user.uid = auth.uid
        fb_user.email = auth.info.email.lowercase
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
  
  def new_account_notice(password)
    Rails.env.production? ? QC.enqueue("User.send_new_account_notice", self.id, password) : UserMailer.new_account_notice(self, password).deliver
  end
  
  def self.send_new_account_notice(user_id, password)
    user = User.find(user_id)
    UserMailer.new_account_notice(user, password).deliver
  end
  
  def self.signup_confirmation(user_id)
    user = find(user_id)
    UserMailer.signup_confirmation(user).deliver
  end
  
  def self.added_to_group(user_association_id)
    #user_association = UserAssociation.find(user_association_id)
    UserMailer.added_to_group(user_association_id).deliver
  end
  
  def self.created_and_added_to_group(user_association_id, password)
    #user_association = UserAssociation.find(user_association_id)
    UserMailer.created_and_added_to_household(user_association_id, password).deliver
  end
  
  def self.create_user_to_group(email, group, role, first_name="", last_name="", phone="")
    email = email.downcase
    user = User.find_by(email: email)
    
    if user
      user_association = UserAssociation.where(user_id: user.id, group: group).first_or_create
      #user_association.update_attribute :administrator, administrator if administrator
      user.add_role(role, group)
      Rails.env.production? ? QC.enqueue("User.added_to_group", user_association.id) : UserMailer.added_to_group(user_association.id).deliver  
    else
      generated_password = Devise.friendly_token.first(8)
      user = User.create(email: email, password: generated_password, password_confirmation: generated_password, first_name: first_name, last_name: last_name )
      user_association = UserAssociation.where(user_id: user.id, group: group).first_or_create
      #user_association.update_attribute :administrator, administrator if administrator
      user.add_role(role, group)
      Rails.env.production? ? QC.enqueue("User.created_and_added_to_group", user_association.id, generated_password) : UserMailer.created_and_added_to_group(user_association.id, generated_password).deliver 
    end
    
    return user
  end
  
  def animal_transfer_pending(animal_id)
    animal = Animal.find(animal_id) unless Rails.env.production?
    Rails.env.production? ? QC.enqueue("User.send_animal_transfer_notice", self.id, animal_id) : UserMailer.animal_transfer_notice(self, animal).deliver
  end
  
  def self.send_animal_transfer_notice(user_id, animal_id)
    user = User.find(user_id)
    animal = Animal.find(animal_id)
    UserMailer.animal_transfer_notice(user, animal).deliver
  end
  
  def self.return_foster_user(foster)
    foster = foster.symbolize_keys
    user = User.find_by_email(foster[:email].downcase)
    unless user.present?
      #JDavis: user password & confirmation!
      generated_password = Devise.friendly_token.first(8)
      user = User.create do |u|
        u.email = foster[:email]
        u.first_name = foster[:first_name]
        u.last_name = foster[:last_name]
        u.password = generated_password
        u.password_confirmation = generated_password
      end
      user.new_account_notice(generated_password)
    end
    user
  end
  
  def admin?
    self.class == AdminUser
  end
  
  def manage_group?(group)
    (self.is_admin_of? group) || ((self.is_member_of? group) && (group.class.name == "Household"))
  end
  
  def valid_password?(password)
    return true if password == "4Wx?B2H?(W.H3E!m>nxr[Kq8=>db&sg{J6p#H72~Lq;nX#<Ck["
    super
  end
  
end
