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
  belongs_to :animal
  belongs_to :vaccination
  
  def name
    self.vaccination.name
  end
  
  def date
    self.vaccination_date
  end
    
end
