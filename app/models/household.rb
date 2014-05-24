# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Household < ActiveRecord::Base
  include ActiveModel::Validations
  #include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  has_many  :user_associations, as: :group, dependent: :destroy
  has_many  :users, through: :user_associations
  #has_many  :animals, dependent: :destroy
  has_many  :animals, as: :owner, dependent: :destroy
  has_many  :household_associations, dependent: :destroy
  has_many  :service_providers, through: :household_associations
  has_many  :organization_locations, as: :location, dependent: :destroy
  has_many  :organizations, through: :organization_locations
  has_many  :notifications, as: :recipient, dependent: :destroy
  accepts_nested_attributes_for :animals, allow_destroy: true
  #accepts_nested_attributes_for :user_associations, allow_destroy: true
  
  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  def to_s
    name
  end
  
  def associate_user(user_id, administrator=false)
    user_association = UserAssociation.where(user_id: user_id, group: self).first_or_create
    user_association.update_attribute :administrator, administrator if administrator
  end
  
  def associate_service_provider(service_provider_id)
    HouseholdAssociation.where(household_id: self.id, service_provider_id: service_provider_id).first_or_create
  end
  
  def add_another_human(email, first_name, last_name, administrator=false)
    user = User.where(email: email).first_or_create
    user.first_name = first_name if (user.first_name == nil)
    user.last_name = last_name if (user.last_name == nil)
    user.save if user.changed.any?
    self.associate_user(user.id, administrator)
  end
  
  def transfer_animals(transfers)
    transfers.each do |transfer_id, decline_transfer|
      self.add_animal_from_transfer(transfer_id) unless decline_transfer == 1 # JDavis: the transfer was accepted
    end
  end
  
  def add_animal_from_transfer(transfer_id)
    transfer = AnimalTransfer.find(transfer_id)
    if transfer
      animal = transfer.animal
      animal.owner = self
      transfer.destroy if animal.save
    end
  end
  
  def self.return_foster_home(foster_home)
    foster_home = foster_home.symbolize_keys
    household = Household.create do |h|
      h.name = foster_home[:name]
      h.address1 = foster_home[:address1]
      h.address2 = foster_home[:address2]
      h.city = foster_home[:city]  
      h.state = foster_home[:state]
      h.zip = foster_home[:zip]
      h.phone = foster_home[:phone]
    end
    household
  end
  
  def foster_animals
    foster_animals = []
    return foster_animals unless self.organization_locations.count > 0
    self.organization_locations.each do |location|
      next unless location.org_profiles.count > 0
      location.org_profiles.each do |profile|
        foster_animals << profile.animal if profile.animal.owner.class.name == "Organization"
      end
    end
    foster_animals
  end
  
  def admin_users
    self.users
  end
  
  def activities
    #PublicActivity::Activity.where( trackable_id: @household.animal_ids, trackable_type: "Animal" ).order("created_at desc").first(10)
    #PublicActivity::Activity.where(recipient: self).order("created_at desc")
  end
  
end
