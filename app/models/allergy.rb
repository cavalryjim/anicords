# == Schema Information
#
# Table name: allergies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Allergy < ActiveRecord::Base
  has_many :animals, through: :animal_allergies
  has_many :animal_allergies
  
end
