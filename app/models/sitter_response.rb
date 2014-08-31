# == Schema Information
#
# Table name: sitter_responses
#
#  id                :integer          not null, primary key
#  sitter_request_id :integer
#  user_id           :integer
#  response          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class SitterResponse < ActiveRecord::Base
  
  belongs_to :sitter_request
  belongs_to :user
  
  def sitter_name
    user.name
  end
end
