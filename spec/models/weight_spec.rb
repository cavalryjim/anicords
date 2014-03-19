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

require 'spec_helper'

describe Weight do
  pending "add some examples to (or delete) #{__FILE__}"
end
