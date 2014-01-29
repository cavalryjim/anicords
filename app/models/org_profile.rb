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
#  petfinder_id             :integer
#  shelter_specific_id      :string(255)
#  thumbnail_url            :string(255)
#  adoption_date            :date
#  transferee_first_name    :string(255)
#  transferee_last_name     :string(255)
#  transferee_phone         :string(255)
#  transferee_city          :string(255)
#  transferee_state         :string(255)
#  transferee_zip           :string(255)
#

class OrgProfile < ActiveRecord::Base
  belongs_to  :animal
  belongs_to  :organization_location
  
  
end
