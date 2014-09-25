# == Schema Information
#
# Table name: animals
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  animal_type_id       :integer
#  description          :text
#  breeder_id           :integer
#  created_at           :datetime
#  updated_at           :datetime
#  dob                  :date
#  food                 :string(255)
#  volume_per_serving   :decimal(, )
#  servings_per_day     :integer
#  pedigree             :string(255)
#  pedigree_chart       :string(255)
#  health_certification :string(255)
#  vaccination_record   :string(255)
#  show_name            :string(255)
#  registration_number  :string(255)
#  serving_measure      :string(255)
#  shampoo_id           :integer
#  treat_id             :integer
#  vitamin_id           :integer
#  gender               :string(255)
#  neutered             :boolean
#  food_id              :integer
#  special_instructions :text
#  microchip_id         :string(255)
#  qr_code_uid          :string(255)
#  qr_code_name         :string(255)
#  organization_id      :integer
#  owner_id             :integer
#  owner_type           :string(255)
#  neutered_date        :date
#  registration_club_id :integer
#  fur_color            :string(255)
#  disposition          :string(255)
#  avatar_uid           :string(255)
#  avatar_name          :string(255)
#  size                 :string(255)
#  pedigreed            :boolean
#  microchipped         :boolean
#  neuter_location      :string(255)
#  microchip_brand_id   :integer
#  active               :boolean          default(TRUE)
#  qr_code_date         :date
#

class Animal < ActiveRecord::Base
  include ActiveModel::Validations
  #include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  belongs_to :owner, polymorphic: true
  belongs_to :animal_type
  belongs_to :breeder
  belongs_to :organization
  belongs_to :microchip_brand
  #belongs_to :household
  #belongs_to :breed
  has_one    :animal_transfer, dependent: :destroy
  has_one    :org_profile, dependent: :destroy
  has_one    :health_profile, dependent: :destroy
  has_many   :documents, dependent: :destroy
  has_many   :vaccinations, through: :animal_vaccinations
  has_many   :animal_vaccinations, dependent: :destroy
  has_many   :medical_diagnoses, through: :animal_diagnoses
  has_many   :animal_diagnoses, dependent: :destroy
  has_many   :medications, through: :animal_medications
  has_many   :animal_medications, dependent: :destroy
  has_many   :allergies, through: :animal_allergies
  has_many   :animal_allergies, dependent: :destroy
  has_many   :service_providers, through: :animal_associations
  has_many   :animal_associations, dependent: :destroy
  has_many   :pictures, dependent: :destroy
  has_many   :personality_types, through: :dispositions
  has_many   :dispositions, dependent: :destroy
  has_many   :breeds, through: :animal_breeds
  has_many   :animal_breeds, dependent: :destroy
  has_many   :adoptions, dependent: :destroy
  has_many   :notifications, dependent: :destroy
  has_many   :weights, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :animal_vaccinations, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
  accepts_nested_attributes_for :org_profile, allow_destroy: true
  accepts_nested_attributes_for :health_profile, allow_destroy: true
  accepts_nested_attributes_for :weights, allow_destroy: true
  accepts_nested_attributes_for :animal_associations, allow_destroy: true
  
  validates_presence_of :name
  after_create :new_health_profile
  before_save  :check_neutered_microchipped_pedigreed
  
  dragonfly_accessor :qr_code do
    storage_options do |attachment|
      { path: "qr_codes/#{Rails.env}/#{id}_#{qr_code_date}.png" }
    end
  end
  
  dragonfly_accessor :avatar do
    storage_options do |attachment|
      { path: "avatars/#{Rails.env}/#{id}_#{Date.today}.png" }
    end
  end
 
  EXCEPT_ATTRS = %w{ household_id breeder_id pedigree_chart health_certification show_name registration_number treat_id microhcip_id organization_id registration_club_id }
  
  def to_s
    name
  end
  
  def pedigree_path
    self.pedigree.path
  end
  
  def breed_names
    (self.breeds.map { |b| b.name } * ", " ) #if self.breeds.count > 0
  end
  
  def species
    self.animal_type.short_name if self.animal_type
  end
  
  def species_long_name
    self.animal_type.name if self.animal_type
  end
  
  def feeding_comment
    if volume_per_serving && serving_measure && servings_per_day
      measure = (volume_per_serving > 1) ? serving_measure : serving_measure.singularize
      times = (servings_per_day > 1) ? 'times' : 'time'
      volume_per_serving.to_s + ' ' + measure + ' / ' + servings_per_day.to_s + ' ' + times + ' per day'
    else
      nil
    end
  end
  
  def transfer_ownership(new_owner, url="")
    # JDavis: need to change the notifications to the new owner.  jdhere
    new_owner = new_owner.symbolize_keys
    user = User.find_by(email: new_owner[:email])
    
    unless user
      generated_password = Devise.friendly_token.first(8)
      user = User.new do |u|
        u.email = new_owner[:email]
        u.first_name = new_owner[:first_name]
        u.last_name = new_owner[:last_name]
        u.address1 = new_owner[:address1]
        u.city = new_owner[:city]
        u.state = new_owner[:state]
        u.zip = new_owner[:zip]
        u.phone = new_owner[:phone]
        u.password = generated_password
        u.password_confirmation = generated_password
      end
      user.new_account_notice(generated_password) if user.save
    end
    
    if user.persisted?
      transfer = AnimalTransfer.where(animal_id: self.id, transferee: user).first_or_create 
      org_profile.update_attribute :organization_location_id, nil  if org_profile.present?
      user.notifications.create(message: "transfer pending", url: url, event: transfer, animal_id: self.id )
      user.animal_transfer_pending(self.id)
      return user.id
    else
      return false
    end
  end
  
  def pending_transfer?
    animal_transfer ? true : false
  end
  
  def cancel_transfer
    animal_transfer.destroy if self.animal_transfer.present?
  end
  
  def has_notifications?
    notifications.where(active: true).present?
  end
  
  def fixed
    neutered ? 'Yes' : 'No'
  end
  
  def neutered_term
    (self.gender == 'female') ? 'Spayed' : 'Neutered'
  end
  
  def food_preference
    food_id ? Food.find(food_id).name : "None"
  end
  
  def create_qr_code(url = nil)
    if Rails.env.production?
      host = "https://animalminder.com"
    else
      host = "localhost:3000"
    end
    
    url = Rails.application.routes.url_helpers.animal_url(self, m: 'qrc', host: host)
    
    #self.update_attribute :qr_code, nil if self.qr_code.present?
    qr_size = 4
    qr_code = nil
    
    while qr_code == nil && qr_size < 10
      begin
        qr_code = RQRCode::QRCode.new(url, :size => qr_size, :level => :h)
      rescue RQRCode::QRCodeRunTimeError => e
        qr_size += 1
      end
    end
    
    if qr_code 
      self.qr_code_date = Date.today  
      self.qr_code = qr_code.to_img.to_string
      self.save
    end
  end

  def profile_completion
    ((self.attributes.reject{|attr| EXCEPT_ATTRS.include?(attr)}.values.select(&:present?).count.to_f / self.attributes.reject{|attr| EXCEPT_ATTRS.include?(attr)}.count.to_f) * 100).round
  end
  
  def needs_vaccination_info?
     vaccinations.count == 0 
  end
  
  def needs_diet_info?
    food_id.blank? || volume_per_serving.blank? || servings_per_day.blank? || serving_measure.blank? 
  end
  
  def inspect_params(params)
    # JDavis: want to move the logic here...not working at the moment.
    # JDavis: creating these preferences if they do not exist.
    params[:food_id] = Food.new_submission(params[:food_id], params[:animal_type_id]) unless (Integer(params[:food_id]) rescue false)
    params[:shampoo_id] = Shampoo.new_submission(params[:shampoo_id], params[:animal_type_id]) unless (Integer(params[:shampoo_id]) rescue false)
    params[:treat_id] = Treat.new_submission(params[:treat_id], params[:animal_type_id]) unless (Integer(params[:treat_id]) rescue false)
    params[:vitamin_id] = Vitamin.new_submission(params[:vitamin_id], params[:animal_type_id]) unless (Integer(params[:vitamin_id]) rescue false)
    # JDavis: Select2 is a pain and insists upon screwing up the submission of selected items.  This is a fix.
    #params[:medical_diagnosis_ids] = self.fix_ids(params[:medical_diagnosis_ids]) unless params[:medical_diagnosis_ids] == "[]"
    params[:medical_diagnosis_ids] = [5, 7, 26]
    params[:medication_ids] = self.fix_ids(params[:medication_ids]) unless params[:medication_ids] == "[]"
    params[:allergy_ids] = self.fix_ids(params[:allergy_ids]) unless params[:allergy_ids] == "[]"
    
    return params
  end
  
  def self.fix_breed_ids(ids)
    ids << ","
    ids = ids.split(']').last.split(",").map { |s| s.to_i }
    ids.delete(0)
    return ids
  end
  
  def fix_ids(ids)
    ids << ","
    ids = ids.split(']').last.split(",").map { |s| s.to_i }
    ids.delete(0)
    return ids
  end
  
  def org_animal_id
    self.org_profile.org_animal_id if self.org_profile
  end
  
  def petfinder_id
    self.org_profile.petfinder_id if self.org_profile
  end
  
  def self.without_org_profile
    Animal.where("id NOT IN (SELECT animal_id FROM org_profiles) AND owner_type = 'Organization'")
  end
  
  def self.without_breeder_profile
    #Animal.where("id NOT IN (SELECT animal_id FROM breeder_profiles) AND owner_type = 'Breeder'")
    true
  end
  
  def vaccination_documents
    self.documents.where(file_type: 'vaccination')
  end
  
  def weight
    self.weights.order('measure_date').last
  end
  
  def rabies_documents
    self.documents.where(file_type: 'rabies')
  end
  
  def veterinary_documents
    self.documents.where(file_type: 'veterinary')
  end
  
  def other_documents
    self.documents.where.not(file_type: ['vaccination', 'rabies', 'veterinary'])
  end
  
  def set_org_location
    self.build_org_profile unless self.org_profile.present?
    self.org_profile.organization_location_id = self.owner.organization_locations.first.id 
    self.org_profile.save unless self.new_record?
  end
  
  def weight_chart_data
    self.weights.order(:measure_date).map{ |w| [w.measure_date.to_datetime, w.measure_num] }
  end
  
  def send_vaccination_notification(msg)
    # JDavis: need to add where receive_notifications: true.  jdhere
    if self.owner.class.name == "Household"
      users = self.owner.users
    elsif self.owner.class.name == "Organization"
      users = self.owner.admin_users
      if self.org_profile.organization_location && self.org_profile.organization_location.location.class.name == "Household"
        users = users + self.org_profile.organization_location.location.users
      end
    end
    
    users.each do |user|
      UserMailer.vaccination_notice(user, self, msg).deliver 
    end
  end
  
  def self.create_qr_code_for_all
    cnt = 0
    Animal.find_each do |animal|
      if false # animal.qr_code.present?
        animal.qr_code = nil
        animal.save
        animal.create_qr_code 
        cnt += 1
      end
    end
    cnt
  end
  
  def check_in(service_provider_id)
    #animal_association = AnimalAssociation.where(animal_id: self.id, service_provider_id: service_provider_id).first_or_create
    #animal_association.update_attribute :checked_in, true
    #animal_association
  end
  
  # JDavis: need to add microchip lookup to this!
  def self.org_animal_search(animal_id, org_animal_id, petfinder_id, organization, chip_brand = nil, chip_id = nil, animal_name, animal_type_id, import_type)
    if animal_id.present? 
      animal = find_by_id(animal_id)
      return animal if (animal && animal.owner == organization)
    end
    
    if org_animal_id.present? 
      profiles = OrgProfile.where(org_animal_id: org_animal_id.to_s, :organization_location_id => organization.organization_location_ids)
      return profiles.first.animal if profiles.present?
    end
    
    if petfinder_id.present? 
      profiles = OrgProfile.where(petfinder_id: petfinder_id, :organization_location_id => organization.organization_location_ids)
      return profiles.first.animal if profiles.present?
    end
    
    if chip_brand.present? && chip_id.present?
      animal = microchip_search(chip_brand, chip_id).first
      return animal if (animal && animal.owner == organization)
    end
    
    animals = organization.animals.where(name: animal_name, animal_type_id: animal_type_id )
    return nil if animals.blank?
    
    # JDavis: if an organization wants to import multiple animals with the same name, they must also provide an unique id 
    #if animals.present? && animals.last.org_profile.org_animal_id.blank?
    #  return animals.last
    #elsif animals.present? && (org_animal_id.present? || animal_id.present? || petfinder_id.present?)
    #  return nil
    #elsif animals.present?
    #  return animals.last
    #end
    return_animal = nil
    animals.each do |a|
      return_animal = a if (((import_type == 'spreadsheet') && a.org_profile.org_animal_id.blank? ) || ((import_type == 'petfinder') && a.org_profile.petfinder_id.blank? ))
    end

    return return_animal
    
  end
  
  def self.microchip_search(chip_brand, chip_id)
    if chip_brand.present?
      where(microchip_brand_id: chip_brand, microchip_id: chip_id)
    else
      where(microchip_id: chip_id)  
    end
  end
  
  def vaccinations_due(as_of_date = (Date.today + 2.weeks) )
    self.animal_vaccinations.where(notify: true, vaccination_due: (Date.today - 2.year)..as_of_date )
  end
  
  def archive
    update_attribute :active, false
  end
  
  def heartworm_medications
    self.animal_medications.where(medication_type: 'heartworm')
  end
  
  def other_medications
    self.animal_medications.where.not(medication_type: 'heartworm')
  end
  
  def contact_owner( message, sender_id = nil, sender_name = nil, sender_contact = nil )
    return false unless message.present?
    #sender = User.find(sender_id)
    
    UserMailer.animal_owner_message(self, message, sender_name, sender_contact ).deliver 
  end
  
  private
  
  def new_health_profile
    self.create_health_profile
  end
  
  def check_neutered_microchipped_pedigreed
    unless self.neutered
      self.neutered_date = nil
      self.neuter_location = nil
    end
  end
  
  
end
