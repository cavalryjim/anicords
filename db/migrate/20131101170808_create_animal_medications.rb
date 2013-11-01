class CreateAnimalMedications < ActiveRecord::Migration
  def change
    create_table :animal_medications do |t|
      t.integer :animal_id
      t.integer :medication_id

      t.timestamps
    end
  end
end
