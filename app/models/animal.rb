# == Schema Information
#
# Table name: animals
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  animal_type_id       :integer
#  breed                :string(255)
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
#

class Animal < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal_type
  belongs_to :breeder
  belongs_to :household
  has_many   :documents, dependent: :destroy
  has_many   :vaccinations, through: :animal_vaccinations
  has_many   :animal_vaccinations, dependent: :destroy
  has_many   :medical_diagnoses, through: :animal_diagnoses
  has_many   :animal_diagnoses, dependent: :destroy
  has_many   :medications, through: :animal_medications
  has_many   :animal_medications, dependent: :destroy
  has_many   :allergies, through: :animal_allergies
  has_many   :animal_allergies, dependent: :destroy
  has_many   :foods, through: :animal_foods
  has_many   :animal_foods, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :animal_vaccinations, allow_destroy: true
  
  validates_presence_of :name
  validates :household_id, presence: true, if: :needs_owner?
  
  mount_uploader :pedigree, FileUploader
  mount_uploader :health_certification, FileUploader
  mount_uploader :vaccination_record, FileUploader
  
  def owner
    if self.household_id
      Household.find(self.household_id)
    elsif self.breeder_id
      Breeder.find(self.breeder_id)
    else
      nil
    end
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
    ids << ' '
    ids.split(']').last.split(',')
  end
  
end
