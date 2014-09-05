class GiveOrganizationAdminsTheAdminRole < ActiveRecord::Migration
  # JDavis: this migration will give member rights to any household that does not 
  #         already have someone with the member role.
  def change
    Organization.all.each do |organization|
      admin_users = User.with_role(:admin, organization)
      if admin_users.empty?
        organization.users.each do |user|
          user.add_role :admin, organization
        end
      end
    end
  end
end
