# == Schema Information
#
# Table name: vaccinations
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  recommended_dosage :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  animal_type_id     :integer
#  frequency          :integer
#  series_name        :string(255)
#  series_number      :integer
#  series_interval    :integer
#  series_next_id     :integer
#

class Vaccination < ActiveRecord::Base
  belongs_to  :animal_type
  
  def series?
    series_name.present?
  end
end
