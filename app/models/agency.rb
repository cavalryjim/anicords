# == Schema Information
#
# Table name: agencies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  parish     :string(255)
#  state      :string(255)
#  zip        :string(255)
#  website    :string(255)
#  logo_url   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Agency < ActiveRecord::Base
end
