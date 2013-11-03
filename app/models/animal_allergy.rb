# == Schema Information
#
# Table name: animal_allergies
#
#  id         :integer          not null, primary key
#  animal_id  :integer
#  allergy_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class AnimalAllergy < ActiveRecord::Base
  belongs_to :animal
  belongs_to :allergy
  
  def name
    self.allergy.name
  end
  
end
