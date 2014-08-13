class AddMedicationTypeToAnimalMedications < ActiveRecord::Migration
  def change
    add_column :animal_medications, :medication_type, :string
    
  end
end
