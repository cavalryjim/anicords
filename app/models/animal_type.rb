# == Schema Information
#
# Table name: animal_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class AnimalType < ActiveRecord::Base
  has_many  :animals
  
  def to_s
    self.name
  end
  
end
