# == Schema Information
#
# Table name: breeders
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  website    :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Breeder < ActiveRecord::Base
  include ActiveModel::Validations
  
  has_many  :user_associations, :dependent => :destroy
  has_many  :users, :through => :user_associations
  has_many  :animals
  has_many  :owned_animals, -> { where active: true }, class_name: "Animal", as: :owner, dependent: :destroy
  has_many  :archived_animals, -> { where active: false }, class_name: "Animal",  as: :owner, dependent: :destroy
  accepts_nested_attributes_for :animals, allow_destroy: true
  
  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: "email.blank?"
  
  def associate_user(user_id)
    UserAssociation.where(user_id: user_id, breeder_id: self.id).first_or_create
  end
  
end
