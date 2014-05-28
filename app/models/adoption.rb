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

class Adoption < ActiveRecord::Base
  belongs_to   :organization
  belongs_to   :animal
  validates_presence_of  :organization_id
  validates_presence_of  :animal_id
  
  def transferee_name_or_email
    if transferee_first_name.present? || transferee_last_name.present?
      transferee_first_name.to_s + ' ' + transferee_last_name.to_s
    else
      transferee_email
    end
  end
  
end
