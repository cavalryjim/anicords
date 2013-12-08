# == Schema Information
#
# Table name: notifications
#
#  id             :integer          not null, primary key
#  recipient_id   :integer
#  recipient_type :string(255)
#  message        :string(255)
#  url            :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Notification < ActiveRecord::Base
  belongs_to :recipient, polymorphic: true
end
