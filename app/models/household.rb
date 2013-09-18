# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Household < ActiveRecord::Base
  
  has_many  :user_associations, dependent: :destroy
  has_many  :users, through: :user_associations
  has_many  :animals
  has_many  :household_associations, dependent: :destroy
  has_many  :service_providers, through: :household_associations
  accepts_nested_attributes_for :animals, allow_destroy: true
  
  def associate_user(user_id)
    UserAssociation.where(user_id: user_id, household_id: self.id).first_or_create
  end
  
  def associate_service_provider(service_provider_id)
    HouseholdAssociation.where(household_id: self.id, service_provider_id: service_provider_id).first_or_create
  end
  
end
