# == Schema Information
#
# Table name: foster_homes
#
#  id              :integer          not null, primary key
#  household_id    :integer
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class FosterHome < ActiveRecord::Base
  belongs_to :household
  belongs_to :organization
  
  validates_presence_of :household_id
  validates_presence_of :organization_id
end

