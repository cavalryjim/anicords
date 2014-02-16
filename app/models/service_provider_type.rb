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
  has_many :business_types
  has_many :service_providers, through: :business_types
  has_many :services, dependent: :destroy
  
  validates :name, presence: true
  
  def to_s
    self.name
  end
  
  def add_css_classes(quick_form = false)
    unless quick_form
      (self.name == 'Veterinarian') ? 'service_provider_type veterinarian' : 'service_provider_type'
    else
      (self.name == 'Veterinarian') ? 'service_provider_type_modal veterinarian_modal' : 'service_provider_type_modal'
    end
  end
  
end
