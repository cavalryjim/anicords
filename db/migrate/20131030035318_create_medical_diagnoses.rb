class CreateMedicalDiagnoses < ActiveRecord::Migration
  def change
    create_table :medical_diagnoses do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
