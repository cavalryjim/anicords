# == Schema Information
#
# Table name: veterinarians
#
#  id          :integer          not null, primary key
#  clinic_name :string(255)
#  address1    :string(255)
#  address2    :string(255)
#  city        :string(255)
#  state       :string(255)
#  zip         :string(255)
#  phone       :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Veterinarian < ActiveRecord::Base
  
  has_many  :user_associations, :dependent => :destroy
  has_many  :users, :through => :user_associations
  has_many  :animals
  accepts_nested_attributes_for :animals, allow_destroy: true
  
  def associate_user(user_id)
    UserAssociation.where(user_id: user_id, veterinarian_id: self.id).first_or_create
  end
  
end
