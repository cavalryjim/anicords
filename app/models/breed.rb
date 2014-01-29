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
  #has_many    :animals
  has_many    :animals, through: :animal_breeds
  has_many    :animal_breeds, dependent: :destroy
  
  def to_s
    name
  end
  
  def text
    self.name
  end
  
end
