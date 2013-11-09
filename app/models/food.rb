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
  
  
end
