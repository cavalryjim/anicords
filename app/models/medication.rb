class Medication < ActiveRecord::Base
  has_many :animals, through: :animal_medications
  has_many :animal_medications
  
  
end
