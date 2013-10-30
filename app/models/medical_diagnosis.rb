# == Schema Information
#
# Table name: medical_diagnoses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MedicalDiagnosis < ActiveRecord::Base
  has_many :animals, through: :animal_diagnoses
  has_many :animal_diagnoses, dependent: :destroy
  
  validates_presence_of :name
  
  
end
