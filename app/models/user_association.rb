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
