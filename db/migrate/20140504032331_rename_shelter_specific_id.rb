class RenameShelterSpecificId < ActiveRecord::Migration
  def change
    rename_column(:org_profiles, :shelter_specific_id, :org_animal_id)
  end
end
