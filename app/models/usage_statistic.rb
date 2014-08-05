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

class UsageStatistic < ActiveRecord::Base
  
  def usage_snapshot
    self.users = User.count
    self.animals = Animal.count
    self.households = Household.count
    self.organizations = Organization.count
    self.service_providers = ServiceProvider.count  
  end
  
  def new_users(go_back = 7)
    User.where('created_at >= ?', go_back.days.ago).count
  end
  
  def new_animals(go_back = 7)
    Animal.where('created_at >= ?', go_back.days.ago).count
  end
  
end
