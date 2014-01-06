# == Schema Information
#
# Table name: dispositions
#
#  id                  :integer          not null, primary key
#  animal_id           :integer
#  personality_type_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Disposition < ActiveRecord::Base
  belongs_to  :animal
  belongs_to  :personality_type
  
end
