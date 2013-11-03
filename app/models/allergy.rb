class Allergy < ActiveRecord::Base
  has_many :animals, through: :animal_allergies
  has_many :animal_allergies
  
end
