# == Schema Information
#
# Table name: animals
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  animal_type_id       :integer
#  weight               :decimal(, )
#  description          :text
#  household_id         :integer
#  breeder_id           :integer
#  created_at           :datetime
#  updated_at           :datetime
#  dob                  :date
#  food                 :string(255)
#  volume_per_serving   :decimal(, )
#  servings_per_day     :integer
#  image                :string(255)
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
#  weight_measure       :string(255)
#  breed_id             :integer
#  gender               :string(255)
#  neutered             :boolean
#  food_id              :integer
#  special_instructions :text
#  rfid                 :string(255)
#  qr_code_uid          :string(255)
#  qr_code_name         :string(255)
#  organization_id      :integer
#  owner_id             :integer
#  owner_type           :string(255)
#  neutered_date        :date
#  registration_club_id :integer
#  fur_color            :string(255)
#  disposition          :string(255)
#

class Animal < ActiveRecord::Base
  include ActiveModel::Validations
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  belongs_to :owner, polymorphic: true
  belongs_to :animal_type
  belongs_to :breeder
  belongs_to :organization
  #belongs_to :household
  belongs_to :breed
  has_one    :animal_transfer, dependent: :destroy
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
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :animal_vaccinations, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
  
  validates_presence_of :name
  #validates :household_id, presence: true, if: :needs_owner?
  validate :file_size_validation
  
  mount_uploader :pedigree, FileUploader
  mount_uploader :health_certification, FileUploader
  mount_uploader :vaccination_record, FileUploader
  #mount_uploader :qr_code, FileUploader
  #image_accessor :qr_code
  dragonfly_accessor :qr_code do
    storage_options do |attachment|
      { path: "qr_codes/#{Rails.env}/#{id}.png" }
    end
  end
 
  
  def to_s
    name
  end
  
  def needs_owner?
    if self.breeder_id == nil 
      true
    else
      false
    end
  end
  
  def pedigree_path
    self.pedigree.path
  end
  
  def fix_ids(ids)
    ids << ","
    ids.split(']').last.split(',')
  end
  
  def breed_name
    self.breed.name if self.breed
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
  
  def transfer_ownership(email, first_name="", last_name="", url="")
    user = User.find_by(email: email)
    
    unless user
      generated_password = Devise.friendly_token.first(8)
      user = User.create(email: email, password: generated_password, password_confirmation: generated_password, first_name: first_name, last_name: last_name )
      user.new_account_notice(generated_password) if user
    end
    
    if user
      transfer = AnimalTransfer.where(animal_id: self.id, transferee: user).first_or_create 
      user.notifications.create(message: "transfer pending", url: url, event: transfer )
      user.animal_transfer_pending(self.id)
    end
  end
  
  def pending_transfer?
    animal_transfer ? true : false
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
  
  def create_qr_code(url)
    #@animal.update_attribute :qr_code, RQRCode::QRCode.new(animal_url(@animal), :size => 4, :level => :h ).to_img
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
      qr_code_img = qr_code.to_img
      self.update_attribute :qr_code, qr_code_img.to_string
    end
  end
  
  private
  
  def file_size_validation
    errors[:pedigree] << "should be less than 5MB" if pedigree.size > 5.megabytes
    errors[:health_certification] << "should be less than 5MB" if health_certification.size > 5.megabytes
    errors[:vaccination_record] << "should be less than 5MB" if vaccination_record.size > 5.megabytes
  end
  
  
end
