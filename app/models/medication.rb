# == Schema Information
#
# Table name: medications
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Medication < ActiveRecord::Base
  
  has_many :animals, through: :animal_medications
  has_many :animal_medications
  
  validates_presence_of :name
  
end
