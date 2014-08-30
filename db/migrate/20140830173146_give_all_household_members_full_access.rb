class GiveAllHouseholdMembersFullAccess < ActiveRecord::Migration
  # JDavis: this migration will give member rights to any household that does not 
  #         already have someone with the member role.
  def change
    Household.all.each do |household|
      admin_users = User.with_role(:member, household)
      if admin_users.empty?
        household.users.each do |user|
          user.add_role :member, household
        end
      end
    end
  end
end
