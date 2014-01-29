# == Schema Information
#
# Table name: animal_breeds
#
#  id         :integer          not null, primary key
#  animal_id  :integer
#  breed_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class AnimalBreed < ActiveRecord::Base
  belongs_to  :animal
  belongs_to  :breed
  

end
