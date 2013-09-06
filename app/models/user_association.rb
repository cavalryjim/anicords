# == Schema Information
#
# Table name: user_associations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  breeder_id      :integer
#  household_id    :integer
#  administrator   :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  veterinarian_id :integer
#

class UserAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :breeder
  belongs_to :household
  belongs_to :veterinarian
  
end
