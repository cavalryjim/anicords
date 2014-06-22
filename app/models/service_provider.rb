# == Schema Information
#
# Table name: service_providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  email      :string(255)
#  website    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  latitude   :float
#  longitude  :float
#

class ServiceProvider < ActiveRecord::Base
  #attr_accessible :veterinarians_attributes
  has_many  :households, through: :household_associations
  has_many  :household_associations, dependent: :destroy
  has_many  :services, through: :service_offerings
  has_many  :service_offerings, dependent: :destroy
  has_many  :business_types
  has_many  :service_provider_types, through: :business_types
  has_many  :user_associations, as: :group, dependent: :destroy
  has_many  :users, through: :user_associations
  has_many  :veterinarians, dependent: :destroy
  has_many  :notifications, as: :recipient, dependent: :destroy
  has_many  :animals, through: :animal_associations
  # JDavis: need to add animals that are currently visiting the provider.
  has_many  :animal_associations, dependent: :destroy
  has_many  :current_clients, -> { where 'animal_associations.checked_in' => true }, through: :animal_associations, class_name: "Animal", source: :animal
            
  accepts_nested_attributes_for :veterinarians, allow_destroy: true
  
  validates_presence_of :name
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  before_save :replace_nils_with_blank
  
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?  # JDavis: need to move this to a backgroup process.  jdhere.
  
  #def as_json options={}
  #  { value: id, label: name + ' ' + zip.to_s }
  #end
  
  def to_s
    name
  end
  
  def full_address
    full_address = ""
    full_address << (address1 || "") << " " << (address2 || "") << " " << (city || "") << " " << (state || "") << " " << (zip || "")
  end
  
  def address_changed?
    address1_changed? || address2_changed? || city_changed? || state_changed? || zip_changed?
  end
  
  def services_available
    Service.where(service_provider_type_id: self.service_provider_type_ids).all
  end
  
  def associate_user(user_id, administrator = false)
    user_association = UserAssociation.where(user_id: user_id, group: self).first_or_create
    user_association.update_attribute :administrator, administrator 
  end
  
  def associate_animal(animal_id)
    AnimalAssociation.where(animal_id: animal_id, service_provider_id: self.id).first_or_create
  end
  
  def has_email?
    email.present?
  end
  
  def is_veterinarian?
    self.service_provider_types.map{ |spt| spt.name }.include?("Veterinarian")
  end
  
  def text
    self.name
  end
  
  def replace_nils_with_blank # JDavis: need blanks to properly search for providers by city, state, and zip.
    self.city = '' if self.city.nil?
    self.state = '' if self.state.nil?
    self.zip = '' if self.zip.nil?
  end
  
end
