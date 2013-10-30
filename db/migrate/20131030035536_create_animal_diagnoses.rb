class CreateAnimalDiagnoses < ActiveRecord::Migration
  def change
    create_table :animal_diagnoses do |t|
      t.integer :animal_id
      t.integer :medical_diagnosis_id
      
      t.timestamps
    end
  end
end
