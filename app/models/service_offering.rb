# == Schema Information
#
# Table name: service_offerings
#
#  id                  :integer          not null, primary key
#  service_provider_id :integer
#  service_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class ServiceOffering < ActiveRecord::Base
  belongs_to :service_provider
  belongs_to :service
  
  validates_presence_of :service_provider_id, :service_id
  
end
