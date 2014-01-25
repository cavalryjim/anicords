# == Schema Information
#
# Table name: locations
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
#  website    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  has_many  :organization_locations, as: :location, dependent: :destroy
  has_many  :organizations, through: :organization_locations
end
