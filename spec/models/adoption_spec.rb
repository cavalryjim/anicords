# == Schema Information
#
# Table name: adoptions
#
#  id                    :integer          not null, primary key
#  organization_id       :integer
#  animal_id             :integer
#  organization_user_id  :integer
#  date                  :date
#  location              :string(255)
#  comments              :text
#  transferee_user_id    :integer
#  transferee_first_name :string(255)
#  transferee_last_name  :string(255)
#  transferee_email      :string(255)
#  transferee_phone      :string(255)
#  transferee_address1   :string(255)
#  transferee_address2   :string(255)
#  transferee_city       :string(255)
#  transferee_state      :string(255)
#  transferee_zip        :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'spec_helper'

describe Adoption do
  pending "add some examples to (or delete) #{__FILE__}"
end
