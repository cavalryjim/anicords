# == Schema Information
#
# Table name: user_associations
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  breeder_id          :integer
#  household_id        :integer
#  administrator       :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  veterinarian_id     :integer
#  service_provider_id :integer
#

class UserAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :breeder
  belongs_to :household
  belongs_to :veterinarian
  belongs_to :service_provider
  
  validates :user_id, presence: true
  
  def name
    if self.breeder_id
      self.breeder.name
    elsif self.household_id
      self.household.name
    elsif self.veterinarian_id
      self.veterinarian.name
    elsif self.service_provider_id
      self.service_provider.name
    end
  end
  
  def organization
    if self.household_id
      self.household
    elsif self.service_provider_id
      self.service_provider
    elsif self.breeder_id
      self.breeder
    #elsif self.veterinarian_id
    #  self.veterinarian
    end
  end
  
  def type
    if self.breeder_id
      'breeder'
    elsif self.household_id
      'household'
    elsif self.veterinarian_id
      'veterinarian'
    elsif self.service_provider_id
      'provider'
    end
  end
  
  def user_email
    self.user ? user.email : nil
  end
  
end
