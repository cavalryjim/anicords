# == Schema Information
#
# Table name: weights
#
#  id           :integer          not null, primary key
#  measure_num  :float
#  measure_unit :string(255)
#  measure_date :date
#  animal_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Weight < ActiveRecord::Base
  belongs_to :animal
   
  validates_presence_of :animal_id 
  validates_presence_of :measure_num 
  validates_presence_of :measure_unit
  validates_presence_of :measure_date
end
