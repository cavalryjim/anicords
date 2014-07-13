# == Schema Information
#
# Table name: beta_comments
#
#  id         :integer          not null, primary key
#  comment    :text
#  page_url   :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  email      :string(255)
#

class BetaComment < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :comment
end
