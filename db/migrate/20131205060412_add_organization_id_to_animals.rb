class AddOrganizationIdToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :organization_id, :integer
  end
end
