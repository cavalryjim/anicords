class RenameMedicationTypeToMedicationType < ActiveRecord::Migration
  def change
    rename_column(:medications, :type, :medication_type)
  end
end
