# == Schema Information
#
# Table name: animal_transfers
#
#  id              :integer          not null, primary key
#  animal_id       :integer
#  transferee_id   :integer
#  transferee_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class AnimalTransfer < ActiveRecord::Base
  belongs_to :animal
  belongs_to :transferee, polymorphic: true
  has_many   :notifications, as: :event, dependent: :destroy

  def display_name
    animal.name + " from " + animal.owner.name
  end
  
  def self.older_transfers(go_back = 7)
    where('updated_at <= ?', go_back.days.ago)
  end
  
  def self.remind_transferees
    transfers = AnimalTransfer.older_transfers
    transfers.find_each do |transfer|
      next unless transfer.transferee.class.name == "User"
      #UserMailer.animal_transfer_notice(transfer.transferee, transfer.animal).deliver
    end
  end

end
