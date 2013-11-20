class AddAnimalTypeIdToMedicalDiagnoses < ActiveRecord::Migration
  def change
    add_column :medical_diagnoses, :animal_type_id, :integer
  end
end
