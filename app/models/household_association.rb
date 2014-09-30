# == Schema Information
#
# Table name: household_associations
#
#  id            :integer          not null, primary key
#  household_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#  provider_id   :integer
#  provider_type :string(255)
#

class HouseholdAssociation < ActiveRecord::Base
  belongs_to :household
  belongs_to :provider, polymorphic: true
  
  validates :household_id, presence: true
  
  def name
    self.provider.name
  end
  
end
