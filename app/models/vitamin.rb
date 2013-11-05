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
  
  def text
    self.name
  end
  
end
