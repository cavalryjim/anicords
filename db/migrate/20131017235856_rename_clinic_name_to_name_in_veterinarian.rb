class RenameClinicNameToNameInVeterinarian < ActiveRecord::Migration
  def change
    rename_column(:veterinarians, :clinic_name, :name)
  end
end
