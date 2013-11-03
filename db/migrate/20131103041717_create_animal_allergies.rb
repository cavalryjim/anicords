class CreateAnimalAllergies < ActiveRecord::Migration
  def change
    create_table :animal_allergies do |t|
      t.integer :animal_id
      t.integer :allergy_id
      
      t.timestamps
    end
  end
end
