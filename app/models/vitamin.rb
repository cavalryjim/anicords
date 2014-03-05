# == Schema Information
#
# Table name: vitamins
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Vitamin < ActiveRecord::Base
  belongs_to  :animal_type
  validates_presence_of :name
  validates_presence_of :animal_type_id
  
  def text
    self.name
  end
  
  def self.new_submission(vitamin, animal_type_id)
    Vitamin.create(name: vitamin, animal_type_id: animal_type_id).id
  end
  
end
