class AnimalMedication < ActiveRecord::Base
  belongs_to :animal
  belongs_to :medication
  
  
  def name
    self.medication.name
  end
  
end
