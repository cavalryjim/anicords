# == Schema Information
#
# Table name: animal_medications
#
#  id            :integer          not null, primary key
#  animal_id     :integer
#  medication_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class AnimalMedication < ActiveRecord::Base
  belongs_to :animal
  belongs_to :medication
  
  validates_presence_of :animal_id
  validates_presence_of :medication_id
  
  
  def name
    self.medication.name
  end
  
end
