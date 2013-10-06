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
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :user_associations, dependent: :destroy
  has_many  :breeders, through: :user_associations
  has_many  :households, through: :user_associations
  has_many  :veterinarians, through: :user_associations
 
  def name
    first_name.to_s << ' ' << last_name.to_s
  end
  
  def name_or_email
    if first_name || last_name
      first_name.to_s << ' ' << last_name.to_s
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
    #puts "In model calling mailer for " + user.email
    UserMailer.signup_confirmation(user).deliver
  end
  
  def self.added_to_household(user_id, household_id)
    user = find(user_id)
    household = Household.find(household_id)
    puts "In model calling mailer for " + user.email
    UserMailer.added_to_household(user, household).deliver
  end
  
  def self.created_and_added_to_household(user_id, password, household_id)
    user = find(user_id)
    household = Household.find(household_id)
    puts "In model calling mailer for " + user.email
    UserMailer.created_and_added_to_household(user, password, household).deliver
  end
  
end
