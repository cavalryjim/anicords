# == Schema Information
#
# Table name: user_associations
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  administrator :boolean
#  created_at    :datetime
#  updated_at    :datetime
#  group_id      :integer
#  group_type    :string(255)
#

class UserAssociation < ActiveRecord::Base
  belongs_to :user
  #belongs_to :breeder # JDavis: need to merge with groupa and remove
  #belongs_to :household # JDavis: need to merge with group and remove
  #belongs_to :veterinarian # JDavis: need to merge with group and remove
  #belongs_to :service_provider# JDavis: need to merge with group and remove
  belongs_to :group, polymorphic: true
  
  validates :user_id, presence: true
  
  def name
    group.name
  end
  
  def organization
    group
  end
  
  def type
    group_type.downcase
  end
  
  def user_email
    self.user ? user.email : nil
  end
  
end
