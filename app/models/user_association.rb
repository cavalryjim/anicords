# == Schema Information
#
# Table name: user_associations
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  breeder_id    :integer
#  household_id  :integer
#  administrator :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class UserAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :breeder
  
end
