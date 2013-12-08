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
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  has_many  :user_associations, as: :group, dependent: :destroy
  has_many  :users, through: :user_associations
  #has_many  :animals, dependent: :destroy
  has_many  :animals, as: :owner, dependent: :destroy
  has_many  :household_associations, dependent: :destroy
  has_many  :service_providers, through: :household_associations
  accepts_nested_attributes_for :animals, allow_destroy: true
  #accepts_nested_attributes_for :user_associations, allow_destroy: true
  
  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  def to_s
    name
  end
  
  def associate_user(user_id)
    UserAssociation.where(user_id: user_id, group: self).first_or_create
  end
  
  def associate_service_provider(service_provider_id)
    HouseholdAssociation.where(household_id: self.id, service_provider_id: service_provider_id).first_or_create
  end
  
  def add_another_human(email, first_name, last_name)
    user = User.where(email: email).first_or_create
    user.first_name = first_name if (user.first_name == nil)
    user.last_name = last_name if (user.last_name == nil)
    user.save if user.changed.any?
    self.associate_user(user.id)
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
  
end
