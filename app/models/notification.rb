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
#  active         :boolean          default(TRUE)
#

class Notification < ActiveRecord::Base
  belongs_to :recipient, polymorphic: true
  belongs_to :event,     polymorphic: true
  belongs_to :animal
  
  validates_presence_of :recipient_id, :recipient_type
  validates_presence_of :message
  #before_save :check_event_or_animal

end
