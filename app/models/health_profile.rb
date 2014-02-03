# == Schema Information
#
# Table name: health_profiles
#
#  id                      :integer          not null, primary key
#  animal_id               :integer
#  last_exam_date          :date
#  last_exam_location      :string(255)
#  heartworm_test_date     :date
#  heartworm_test_location :string(255)
#  heartworm_test_result   :boolean
#  fiv_felv_test_date      :date
#  fiv_felv_test_location  :string(255)
#  fiv_felv_test_result    :boolean
#  created_at              :datetime
#  updated_at              :datetime
#

class HealthProfile < ActiveRecord::Base
  belongs_to  :animal
end
