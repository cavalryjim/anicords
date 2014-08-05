# == Schema Information
#
# Table name: usage_statistics
#
#  id                :integer          not null, primary key
#  users             :integer
#  animals           :integer
#  households        :integer
#  organizations     :integer
#  service_providers :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe UsageStatistic do
  pending "add some examples to (or delete) #{__FILE__}"
end
