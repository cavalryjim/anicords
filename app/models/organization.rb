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
  
  def pets_petfinder_ids
    self.animals.map{|a|  a.petfinder_id }.compact
  end
  
  def petfinder_import
    petfinder = Petfinder::Client.new
    pets = petfinder.shelter_pets(self.petfinder_shelter_id, {count: 250})
    petfinder_ids = self.pets_petfinder_ids
    pets.each do |pet|
      #JDavis: check to see if the animal is already in dooliddl.
      next if (petfinder_ids.include? pet.id) # && animal.updated_at < pet.last_update
      animal = Animal.create(name: pet.name, owner: self)
      animal.build_org_profile
      case pet.animal
      when 'Dog'
        animal.animal_type_id = 1
      when 'Cat'
        animal.animal_type_id = 2
      end
      
      case pet.sex
      when 'M'
        animal.gender = 'male'
      when 'F'
        animal.gender = 'female'
      end
      if pet.breeds
        breed = Breed.where(name: pet.breeds.first, animal_type_id: animal.animal_type_id).first
        animal.breed_id = breed.id if breed
      end
      animal.org_profile.thumbnail_url = pet.photos.first.thumbnail if pet.photos
      animal.description = Sanitize.clean(pet.description)
      animal.save
    end

  end
  
  
  
end
