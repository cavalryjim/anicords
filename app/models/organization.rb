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
#  latitude             :float
#  longitude            :float
#

class Organization < ActiveRecord::Base
  include ActiveModel::Validations
  
  #has_many  :adopted_animals, -> { where.not owner_type: "Organization" }, class_name: "Animal"
  has_many  :animals, -> { where active: true }, as: :owner, dependent: :destroy
  has_many  :archived_animals, -> { where active: false }, class_name: "Animal", as: :owner, dependent: :destroy
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
  
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed? # JDavis: need to move this to a backgroup process.  jdhere.
  
  def to_s
    name
  end
  
  def to_param
    "#{id} #{name}".parameterize
  end
  
  def full_address
    full_address = ""
    full_address << (address1 || "") << " " << (address2 || "") << " " << (city || "") << " " << (state || "") << " " << (zip || "")
  end
  
  def address_changed?
    address1_changed? || address2_changed? || city_changed? || state_changed? || zip_changed?
  end
  
  def associate_user(user, role)
    user_association = UserAssociation.where(user_id: user.id, group: self).first_or_create
    #user_association.update_attribute :administrator, administrator 
    user.add_role(role, self)
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
  
  def animal_vaccinations_due(as_of_date = (Date.today + 2.weeks) )
    AnimalVaccination.where(animal_id: self.animal_ids, notify: true, vaccination_due: (Date.today - 2.year)..as_of_date )
  end
  
  def petfinder_import
    petfinder = Petfinder::Client.new
    pets = petfinder.shelter_pets(self.petfinder_shelter_id, {count: 250})
    #org_petfinder_ids = self.petfinder_ids
    pull_count = 0
    pets.each do |pet|
      #JDavis: check to see if the animal is already in AnimalMinder.
      #if (org_petfinder_ids.include? pet.id.to_i)
      #  animal = OrgProfile.find_by_petfinder_id(pet.id.to_i).animal
      #  next if animal.updated_at > pet.last_update
      #else
      #  animal = Animal.create(name: pet.name, owner: self, organization_id: self.id)
      #  animal.build_org_profile
      #  animal.org_profile.petfinder_id = pet.id
      #end 
      case pet.animal
      when 'Dog'
        animal_type_id = 1
      when 'Cat'
        animal_type_id = 2
      end
      
      animal = Animal.org_animal_search(nil, nil, pet.id, self, nil, nil, pet.name, animal_type_id, 'petfinder' ) 
      next if (animal.present? && (animal.updated_at > pet.last_update))
      
      animal = Animal.create(name: pet.name, owner: self, organization_id: self.id) if animal.blank?
      animal.build_org_profile unless animal.org_profile.present?
      
      if pet.photos.present?
        pet.photos.each do |pet_photo|
          Picture.where(animal_id: animal.id, external_url: pet_photo.medium ).first_or_create
        end
        
        animal.org_profile.update_attribute :thumbnail_url, pet.photos.first.thumbnail unless animal.org_profile.thumbnail_url.present?
      end
      
      animal.animal_type_id = animal_type_id
      animal.org_profile.petfinder_id = pet.id
      
      
      case pet.sex
      when 'M'
        animal.gender = 'male'
      when 'F'
        animal.gender = 'female'
      end
      
      if pet.breeds.present?
        pet.breeds.each do |pet_breed|
          breed = Breed.where(name: pet_breed, animal_type_id: animal.animal_type_id).first
          AnimalBreed.where(animal_id: animal.id, breed_id: breed.id).first_or_create if breed
        end
      end
      #animal.org_profile.thumbnail_url = pet.photos.first.thumbnail if pet.photos
      animal.org_profile.organization_location = self.organization_locations.first unless animal.org_profile.organization_location_id.present?
      animal.description = Sanitize.clean(pet.description)
      
      pull_count += 1 if animal.save
      
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
      "disposition", "size", "microchipped", "microchip_brand_id", "microchip_id", "neuter_location" ]    
    allowed_org_profile_attrs = [ "org_animal_id", "intake_date","intake_reason","petfinder_id"]
    spreadsheet = Organization.open_spreadsheet(file)
    header = spreadsheet.row(1)
    import_count = 0
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      next if row["name"].blank?  #JDavis: must have a name
      animal_id = row["id"] || nil
      org_animal_id = row["org_animal_id"] || nil
      petfinder_id = row["petfinder_id"] || nil
      chip_brand = row["microchip_brand_id"] || nil
      chip_id = row["microchip_id"] || nil
      animal_name = row["name"]
      animal_type_id = row["animal_type_id"] || nil
      animal = Animal.org_animal_search(animal_id, org_animal_id, petfinder_id, self, chip_brand, chip_id, animal_name, animal_type_id, 'spreadsheet' ) || Animal.new
      animal.attributes = row.to_hash.select { |k,v| allowed_animal_attrs.include? k }
      animal.owner = self
      animal.organization_id = self.id
      if animal.save
        animal.build_org_profile unless animal.org_profile.present?
        animal.org_profile.attributes = row.to_hash.select { |k,v| allowed_org_profile_attrs.include? k }
        animal.org_profile.organization_location_id ||= self.organization_locations.first.id
        import_count += 1 if animal.org_profile.save
        
        if row["breed_1"].present? && animal.animal_type_id
          breed = Breed.where(name: row["breed_1"], animal_type_id: animal.animal_type_id).first
          AnimalBreed.where(animal_id: animal.id, breed_id: breed.id).first_or_create if breed
        end
        if row["breed_2"].present? && animal.animal_type_id
          breed = Breed.where(name: row["breed_2"], animal_type_id: animal.animal_type_id).first
          AnimalBreed.where(animal_id: animal.id, breed_id: breed.id).first_or_create if breed
        end
        if row["rabies_annual_date"].present?
          v = Vaccination.where(name: "Rabies (annual)", animal_type_id: animal.animal_type_id).first
          av = AnimalVaccination.find_or_initialize_by(animal_id: animal.id, vaccination_id: v.id, vaccination_date: row["rabies_annual_date"])
          av.tag_number = row["rabies_tag_number"] if row["rabies_tag_number"].present?
          av.location = row["rabies_location"] if row["rabies_location"].present?
          av.set_due_date if v.frequency.present?
          av.save
        end
        if row["dhpp_6weeks_date"].present?
          v = Vaccination.where(name: "DHPP (6-8 weeks)", animal_type_id: animal.animal_type_id).first
          av = AnimalVaccination.find_or_initialize_by(animal_id: animal.id, vaccination_id: v.id)
          av.vaccination_date = row["dhpp_6weeks_date"]
          av.tag_number = row["dhpp_6weeks_tag_number"] if row["dhpp_6weeks_tag_number"].present?
          av.location = row["dhpp_6weeks_location"] if row["dhpp_6weeks_location"].present?
          av.save
          av.update_series
        end
        if row["dhpp_10weeks_date"].present?
          v = Vaccination.where(name: "DHPP (10-12 weeks)", animal_type_id: animal.animal_type_id).first
          av = AnimalVaccination.find_or_initialize_by(animal_id: animal.id, vaccination_id: v.id)
          av.vaccination_date = row["dhpp_10weeks_date"]
          av.tag_number = row["dhpp_10weeks_tag_number"] if row["dhpp_10weeks_tag_number"].present?
          av.location = row["dhpp_10weeks_location"] if row["dhpp_10weeks_location"].present?
          av.save
          av.update_series
        end
        if row["dhpp_14weeks_date"].present?
          v = Vaccination.where(name: "DHPP (14-16 weeks)", animal_type_id: animal.animal_type_id).first
          av = AnimalVaccination.find_or_initialize_by(animal_id: animal.id, vaccination_id: v.id)
          av.vaccination_date = row["dhpp_14weeks_date"]
          av.tag_number = row["dhpp_14weeks_tag_number"] if row["dhpp_14weeks_tag_number"].present?
          av.location = row["dhpp_14weeks_location"] if row["dhpp_14weeks_location"].present?
          av.save
          av.update_series
        end
        if row["dhpp_annual_date"].present?
          v = Vaccination.where(name: "DHPP (annual)", animal_type_id: animal.animal_type_id).first
          av = AnimalVaccination.find_or_initialize_by(animal_id: animal.id, vaccination_id: v.id)
          av.vaccination_date = row["dhpp_annual_date"]
          av.tag_number = row["dhpp_annual_tag_number"] if row["dhpp_annual_tag_number"].present?
          av.location = row["dhpp_annual_location"] if row["dhpp_annual_location"].present?
          av.save
          av.update_series
        end
        
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
