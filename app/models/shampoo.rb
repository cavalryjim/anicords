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
  
  def text
    self.name
  end
  
end
