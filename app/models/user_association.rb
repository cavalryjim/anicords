# == Schema Information
#
# Table name: user_associations
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  administrator         :boolean
#  created_at            :datetime
#  updated_at            :datetime
#  group_id              :integer
#  group_type            :string(255)
#  receive_notifications :boolean          default(TRUE)
#

class UserAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :group, polymorphic: true
  
  validates :user_id, presence: true
  
  before_destroy :remove_roles
  
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
  
  def self.orphan_associations
    UserAssociation.where("user_associations.user_id = ? OR user_associations.group_id = ?", nil, nil)
  end
  
  def remove_roles
    group.applied_roles.each do |role|
      user.remove_role role.name, group
    end
    
    # JDavis: need to remove all roles granting a user access to a resources when the association is destroyed. jdhere.
  end
  
end
