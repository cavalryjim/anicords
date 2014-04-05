# == Schema Information
#
# Table name: animal_associations
#
#  id                  :integer          not null, primary key
#  animal_id           :integer
#  service_provider_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#  checked_in          :boolean
#

class AnimalAssociation < ActiveRecord::Base
  belongs_to :animal
  belongs_to :service_provider
  
  validates_presence_of :animal_id
  validates_presence_of :service_provider_id
  
  def name
    self.service_provider.name
  end
  
  def provider_types
    #self.service_provider.service_provider_types.map {|t| t.name }.join(",")
    self.service_provider.service_provider_types.map {|t| t.name }.to_sentence
  end
  
end
