# == Schema Information
#
# Table name: business_types
#
#  id                       :integer          not null, primary key
#  service_provider_id      :integer
#  service_provider_type_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class BusinessType < ActiveRecord::Base
  belongs_to :service_provider_type
  belongs_to :service_provider
  
  def name
    self.service_provider_type.name
  end
  
end
