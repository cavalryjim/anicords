class RemoveFosterHouseholdIdFromOrgProfile < ActiveRecord::Migration
  def change
    remove_column :org_profiles, :foster_household_id
  end
end
