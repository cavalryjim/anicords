# == Schema Information
#
# Table name: animals
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  animal_type_id :integer
#  breed          :string(255)
#  weight         :decimal(, )
#  description    :text
#  household_id   :integer
#  breeder_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Animal < ActiveRecord::Base
  
  belongs_to :animal_type
  belongs_to :user
  belongs_to :breeder
end
