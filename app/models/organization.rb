# == Schema Information
#
# Table name: organizations
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  address1             :string(255)
#  address2             :string(255)
#  city                 :string(255)
#  state                :string(255)
#  zip                  :string(255)
#  phone                :string(255)
#  email                :string(255)
#  website              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  petfinder_shelter_id :string(255)
#

class Organization < ActiveRecord::Base
  include ActiveModel::Validations
  
  #has_many  :adopted_animals, -> { where 'owner_type != "Organization"' },
  #          class_name: "Animal"
  has_many  :animals, as: :owner, dependent: :destroy
  has_many  :user_associations, as: :group, dependent: :destroy
  has_many  :users, through: :user_associations
  has_many  :organization_locations, dependent: :destroy
  has_many  :households, through: :organization_locations, source: :location, source_type: "Household"
  has_many  :locations, through: :organization_locations, source: :location, source_type: "Location"
  
  accepts_nested_attributes_for :animals, allow_destroy: true
  after_create :make_organization_location
  
  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  def to_s
    name
  end
  
  def associate_user(user_id, administrator=false)
    user_association = UserAssociation.where(user_id: user_id, group: self).first_or_create
    user_association.update_attribute :administrator, administrator if administrator
  end
  
  def fosters
    self.households
  end
  
  def make_organization_location
    OrganizationLocation.create(organization_id: self.id, location: self)
  end
  
  def petfinder_import
    true
  end
  
end
