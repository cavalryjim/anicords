# == Schema Information
#
# Table name: service_provider_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ServiceProviderType < ActiveRecord::Base
  has_many :service_providers
  
  validates :name, presence: true
  
  def to_s
    self.name
  end
  
end
