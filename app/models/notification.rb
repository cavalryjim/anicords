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
#  event_id       :integer
#  event_type     :string(255)
#  animal_id      :integer
#

class Notification < ActiveRecord::Base
  belongs_to :recipient, polymorphic: true
  belongs_to :event,     polymorphic: true
  belongs_to :animal
end
