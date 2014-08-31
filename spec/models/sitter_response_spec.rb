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

require 'spec_helper'

describe SitterResponse do
  pending "add some examples to (or delete) #{__FILE__}"
end
