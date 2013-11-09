# == Schema Information
#
# Table name: breeds
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Breed < ActiveRecord::Base
  belongs_to  :animal_type
  has_many    :animals
  
  def text
    self.name
  end
  
end
