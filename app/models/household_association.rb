# == Schema Information
#
# Table name: household_associations
#
#  id                  :integer          not null, primary key
#  household_id        :integer
#  service_provider_id :integer
#  clinic_id           :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class HouseholdAssociation < ActiveRecord::Base
  belongs_to :household
  belongs_to :service_provider
  
  validates :household_id, presence: true
  validates :service_provider_id, presence: true
  
  def name
    if self.service_provider_id
      self.service_provider.name
    elsif self.clinic_id
      self.clinic.name
    end
  end
  
end
