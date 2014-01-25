# == Schema Information
#
# Table name: org_profiles
#
#  id                       :integer          not null, primary key
#  animal_id                :integer
#  intake_date              :date
#  intake_reason            :string(255)
#  neuter_location_id       :integer
#  neuter_location_type     :string(255)
#  intake_weight            :float
#  intake_weight_measure    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  organization_location_id :integer
#

class OrgProfile < ActiveRecord::Base
  belongs_to  :animal
  belongs_to  :organization_location
  
  
end
