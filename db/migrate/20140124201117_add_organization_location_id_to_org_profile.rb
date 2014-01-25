class AddOrganizationLocationIdToOrgProfile < ActiveRecord::Migration
  def change
    add_column :org_profiles, :organization_location_id,  :integer
    remove_column :org_profiles, :location
  end
end
