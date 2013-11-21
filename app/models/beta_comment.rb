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
#

class BetaComment < ActiveRecord::Base
  belongs_to :user
end
