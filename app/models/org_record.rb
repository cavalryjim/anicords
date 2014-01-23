# == Schema Information
#
# Table name: org_records
#
#  id                    :integer          not null, primary key
#  animal_id             :integer
#  intake_date           :date
#  intake_reason         :integer
#  location              :string(255)
#  foster_household_id   :integer
#  neuter_location_id    :integer
#  neuter_location_type  :string(255)
#  intake_weight         :float
#  intake_weight_measure :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class OrgRecord < ActiveRecord::Base
  belongs_to :animal
end
