# == Schema Information
#
# Table name: personality_types
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class PersonalityType < ActiveRecord::Base
  has_many   :animals, through: :dispositions
  has_many   :dispositions, dependent: :destroy
end
