# == Schema Information
#
# Table name: animal_diagnoses
#
#  id                   :integer          not null, primary key
#  animal_id            :integer
#  medical_diagnosis_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class AnimalDiagnosis < ActiveRecord::Base
  belongs_to :animal
  belongs_to :medical_diagnosis
  
  validates_presence_of :animal_id
  validates_presence_of :medical_diagnosis_id
  
  
  def name
    self.medical_diagnosis.name
  end
  
end
