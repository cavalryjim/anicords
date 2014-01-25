# == Schema Information
#
# Table name: organization_locations
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  location_id     :integer
#  location_type   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class OrganizationLocation < ActiveRecord::Base
  belongs_to :organization
  belongs_to :location, polymorphic: true
  has_many   :org_profiles
  
  def to_s
    self.name
  end
  
  def name
    location.name if location.name.present?
  end
end
