# == Schema Information
#
# Table name: registration_clubs
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class RegistrationClub < ActiveRecord::Base
  belongs_to  :animal_type
  has_many    :animals
  
  def to_s
    name
  end
  
  def text
    self.name
  end
end
