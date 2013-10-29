class CreateAnimalVaccinations < ActiveRecord::Migration
  def change
    create_table :animal_vaccinations do |t|
      t.integer :animal_id
      t.integer :vaccination_id
      t.date :vaccination_date
      t.string :dosage 
      t.timestamps
    end
  end
end
