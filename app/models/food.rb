# == Schema Information
#
# Table name: foods
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Food < ActiveRecord::Base
  
  
  def text
    self.name
  end
  
  def self.new_submission(food, animal_type_id)
    Food.create(name: food, animal_type_id: animal_type_id).id
  end
  
  
end
