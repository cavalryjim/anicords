class AddPetfinderIdAndShelterSpecificIdToOrgProfile < ActiveRecord::Migration
  def change
    add_column :org_profiles, :petfinder_id, :integer
    add_column :org_profiles, :shelter_specific_id, :string
  end
end
