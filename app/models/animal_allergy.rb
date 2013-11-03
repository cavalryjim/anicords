class AnimalAllergy < ActiveRecord::Base
  belongs_to :animal
  belongs_to :allergy
  
  def name
    self.allergy.name
  end
  
end
