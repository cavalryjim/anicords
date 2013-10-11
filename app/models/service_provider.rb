# == Schema Information
#
# Table name: service_providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  email      :string(255)
#  website    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ServiceProvider < ActiveRecord::Base
  has_many  :households, through: :household_associations
  has_many  :household_associations, dependent: :destroy
  has_many  :services, through: :service_offerings
  has_many  :service_offerings, dependent: :destroy
  has_many  :business_types
  has_many  :service_provider_types, through: :business_types
  
  validates :name, presence: true
  
  def as_json options={}
    { value: id, label: name + ' ' + zip.to_s }
  end
  
end
