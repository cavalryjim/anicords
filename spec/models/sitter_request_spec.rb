# == Schema Information
#
# Table name: sitter_requests
#
#  id                  :integer          not null, primary key
#  household_id        :integer
#  start_datetime      :datetime
#  end_datetime        :datetime
#  comments            :text
#  confirmed_sitter_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe SitterRequest do
  pending "add some examples to (or delete) #{__FILE__}"
end
