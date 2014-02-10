# == Schema Information
#
# Table name: shampoos
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Shampoo < ActiveRecord::Base
  belongs_to  :animal_type
  
  validates_presence_of :name
  
  def text
    self.name
  end
  
  def self.new_submission(shampoo, animal_type_id)
    Shampoo.create(name: shampoo, animal_type_id: animal_type_id).id
  end
  
end
