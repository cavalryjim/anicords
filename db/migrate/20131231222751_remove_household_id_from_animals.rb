class RemoveHouseholdIdFromAnimals < ActiveRecord::Migration
  def change
    remove_column :animals, :household_id
  end
end
