# == Schema Information
#
# Table name: vaccinations
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  frequency          :string(255)
#  recommended_dosage :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Vaccination < ActiveRecord::Base
end
