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
  include ActiveModel::Validations
  validates_presence_of :name
  
  has_many  :animals
  has_many  :foods
  has_many  :breeds
  has_many  :vaccinations
  
  
  def to_s
    self.name
  end
  
  def short_name
    self.name[/(\S+\s+){#{1}}/].strip
    
  end
  
end
