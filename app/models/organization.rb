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
#  logo_external_url    :string(255)
#

class Organization < ActiveRecord::Base
  include ActiveModel::Validations
  
  #has_many  :adopted_animals, -> { where.not owner_type: "Organization" }, class_name: "Animal"
  has_many  :animals, as: :owner, dependent: :destroy
  has_many  :user_associations, as: :group, dependent: :destroy
  has_many  :users, through: :user_associations
  has_many  :organization_locations, dependent: :destroy
  has_many  :households, through: :organization_locations, source: :location, source_type: "Household"
  has_many  :locations, through: :organization_locations, source: :location, source_type: "Location"
  has_many  :adoptions, dependent: :destroy
  has_many  :notifications, as: :recipient, dependent: :destroy
  has_many  :admin_users, through: :user_associations,
            :class_name => "User",
            :source => :user,
            :conditions => {'user_associations.administrator' => true},
            :order => 'created_at desc'
  
  accepts_nested_attributes_for :animals, allow_destroy: true
  after_create :make_organization_location
  
  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  def to_s
    name
  end
  
  def associate_user(user_id, administrator = false)
    user_association = UserAssociation.where(user_id: user_id, group: self).first_or_create
    user_association.update_attribute :administrator, administrator 
  end
  
  def associate_location(location)
    OrganizationLocation.where(organization_id: self.id, location: location).first_or_create
  end
  
  def fosters
    self.households
  end
  
  def make_organization_location
    OrganizationLocation.create(organization_id: self.id, location: self)
  end
  
  def petfinder_ids
    self.animals.map{|a|  a.petfinder_id }.compact
  end
  
  def petfinder_import
    petfinder = Petfinder::Client.new
    pets = petfinder.shelter_pets(self.petfinder_shelter_id, {count: 250})
    org_petfinder_ids = self.petfinder_ids
    pull_count = 0
    pets.each do |pet|
      #JDavis: check to see if the animal is already in Petabyt.
      if (org_petfinder_ids.include? pet.id.to_i)
        animal = OrgProfile.find_by_petfinder_id(pet.id.to_i).animal
        next if animal.updated_at > pet.last_update
      else
        animal = Animal.create(name: pet.name, owner: self, organization_id: self.id)
        animal.build_org_profile
        animal.org_profile.petfinder_id = pet.id
      end 
      
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
        pet.breeds.each do |pet_breed|
          breed = Breed.where(name: pet_breed, animal_type_id: animal.animal_type_id).first
          AnimalBreed.where(animal_id: animal.id, breed_id: breed.id).first_or_create if breed
        end
      end
      animal.org_profile.thumbnail_url = pet.photos.first.thumbnail if pet.photos
      (animal.org_profile.organization_location_id = self.organization_locations.first.id) unless animal.org_profile.organization_location_id.present?
      animal.description = Sanitize.clean(pet.description)
      
      pull_count += 1 if animal.save
      
      if animal.id && pet.photos
        pet.photos.each do |pet_photo|
          Picture.where(animal_id: animal.id, external_url: pet_photo.medium ).first_or_create
        end
      end
      
    end
    "Pulled information for #{pull_count} animals from Petfinder."
  end
  
  def capture_transfer(animal_id, transferee_id, transferee_info, org_info )
    transferee_info = transferee_info.symbolize_keys
    org_info = org_info.symbolize_keys
    
    adoption = self.adoptions.new do |a|
      a.animal_id = animal_id
      a.organization_user_id = org_info[:organization_user_id]
      a.date = Time.now
      a.location = org_info[:location]
      a.comments = org_info[:comments]
      a.transferee_user_id = transferee_id
      a.transferee_email = transferee_info[:email]
      a.transferee_first_name = transferee_info[:first_name]
      a.transferee_last_name = transferee_info[:last_name]
      a.transferee_address1 = transferee_info[:address1]
      a.transferee_city = transferee_info[:city]
      a.transferee_state = transferee_info[:state]
      a.transferee_zip = transferee_info[:zip]
      a.transferee_phone = transferee_info[:phone]
    end
    adoption.save
  end
  
  def spreadsheet_import(file)
    allowed_animal_attrs = [ "name", "animal_type_id", "description", "dob", "gender", "neutered", "neutered_date", "special_instructions", "fur_color",
      "disposition", "size", "microchipped", "microchip_brand_id", "microchip_id" ]    
    allowed_org_profile_attrs = [ "org_animal_id", "intake_date","intake_reason","petfinder_id"]
    spreadsheet = Organization.open_spreadsheet(file)
    header = spreadsheet.row(1)
    import_count = 0
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      animal_id = row["id"] || nil
      org_animal_id = row["org_animal_id"] || nil
      petfinder_id = row["petfinder_id"] || nil
      animal = Animal.org_animal_search(animal_id, org_animal_id, petfinder_id, self ) || Animal.new
      animal.attributes = row.to_hash.select { |k,v| allowed_animal_attrs.include? k }
      animal.owner = self
      animal.organization_id = self.id
      if animal.save
        animal.build_org_profile unless animal.org_profile.present?
        animal.org_profile.attributes = row.to_hash.select { |k,v| allowed_org_profile_attrs.include? k }
        animal.org_profile.organization_location_id ||= self.organization_locations.first.id
        import_count += 1 if animal.org_profile.save
      end
     
    end
    "Imported #{import_count} animals."
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
    
end
