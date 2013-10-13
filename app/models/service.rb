# == Schema Information
#
# Table name: services
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  service_provider_type_id :integer
#

class Service < ActiveRecord::Base
  belongs_to :service_provider_type
  has_many  :service_providers, through: :service_offerings
  has_many  :service_offerings, dependent: :destroy
  
  validates :name, presence: true 
  
end
