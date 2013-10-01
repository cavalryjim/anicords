# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base
  has_many  :service_providers, through: :service_offerings
  has_many  :service_offerings, dependent: :destroy
  
  validates :name, presence: true 
  
end
