# == Schema Information
#
# Table name: treats
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Treat < ActiveRecord::Base
  belongs_to  :animal_type
  validates_presence_of :name
  validates_presence_of :animal_type_id
  
  def text
    self.name
  end
  
  def self.new_submission(treat, animal_type_id)
    Treat.create(name: treat, animal_type_id: animal_type_id).id
  end
  
end
