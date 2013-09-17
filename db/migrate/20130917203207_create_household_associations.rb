class CreateHouseholdAssociations < ActiveRecord::Migration
  def change
    create_table :household_associations do |t|
      t.integer :household_id
      t.integer :service_provider_id
      t.integer :clinic_id

      t.timestamps
    end
  end
end
