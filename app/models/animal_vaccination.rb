# == Schema Information
#
# Table name: animal_vaccinations
#
#  id               :integer          not null, primary key
#  animal_id        :integer
#  vaccination_id   :integer
#  vaccination_date :date
#  dosage           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class AnimalVaccination < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  belongs_to :vaccination
  
  validates_presence_of :animal_id
  validates_presence_of :vaccination_id
  validates_presence_of :vaccination_date
  
  def name
    self.vaccination.name
  end
  
  def date
    self.vaccination_date
  end
    
end
