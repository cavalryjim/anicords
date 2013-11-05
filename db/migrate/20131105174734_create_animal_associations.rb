class CreateAnimalAssociations < ActiveRecord::Migration
  def change
    create_table :animal_associations do |t|
      t.integer :animal_id
      t.integer :service_provider_id
      t.timestamps
    end
  end
end
