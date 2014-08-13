class RenameMedicationTypeToMedicationType < ActiveRecord::Migration
  def change
    if self.table_exists?("type")
      rename_column(:medications, :type, :medication_type) 
    else
      add_column :medications, :medication_type, :string
    end
  end
end
