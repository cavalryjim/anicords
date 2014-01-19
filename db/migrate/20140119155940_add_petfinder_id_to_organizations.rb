class AddPetfinderIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :petfinder_shelter_id,  :string
  end
end
