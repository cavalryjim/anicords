# == Schema Information
#
# Table name: service_providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  email      :string(255)
#  website    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ServiceProvider < ActiveRecord::Base
  has_many  :households, through: :household_associations
  has_many  :household_associations, dependent: :destroy
  has_many  :services, through: :service_offerings
  has_many  :service_offerings, dependent: :destroy
  has_many  :business_types
  has_many  :service_provider_types, through: :business_types
  has_many  :user_associations, dependent: :destroy
  has_many  :users, through: :user_associations
  
  validates :name, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  def as_json options={}
    { value: id, label: name + ' ' + zip.to_s }
  end
  
  def services_available
    Service.where(service_provider_type_id: self.service_provider_type_ids).all
  end
  
  def associate_user(user_id)
    UserAssociation.where(user_id: user_id, service_provider_id: self.id).first_or_create
  end
  
  def has_email?
    self.email != nil && self.email != ''
  end
  
end
