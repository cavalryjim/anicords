# == Schema Information
#
# Table name: microchip_brands
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  website    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MicrochipBrand < ActiveRecord::Base
  
  has_many :animals
  validates_presence_of :name
  
end
