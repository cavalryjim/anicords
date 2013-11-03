# == Schema Information
#
# Table name: animal_foods
#
#  id         :integer          not null, primary key
#  animal_id  :integer
#  food_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class AnimalFood < ActiveRecord::Base
  belongs_to :animal
  belongs_to :food
  
  def name
    self.food.name
  end
  
end
