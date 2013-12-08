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

end