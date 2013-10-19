# == Schema Information
#
# Table name: veterinarians
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  address1            :string(255)
#  address2            :string(255)
#  city                :string(255)
#  state               :string(255)
#  zip                 :string(255)
#  phone               :string(255)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  service_provider_id :integer
#

class Veterinarian < ActiveRecord::Base
  belongs_to  :service_provider
  
  validates_presence_of :name
  
end
