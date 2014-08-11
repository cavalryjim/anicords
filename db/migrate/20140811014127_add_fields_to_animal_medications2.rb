class AddFieldsToAnimalMedications2 < ActiveRecord::Migration
  def change
    add_column :animal_medications, :medication_date, :date
    add_column :animal_medications, :medication_due, :date
    add_column :animal_medications, :notification_count, :integer
    add_column :animal_medications, :notify, :boolean, default: true
    add_column :animal_medications, :notify_on, :date
    add_column :animal_medications, :location, :string
    add_column :animal_medications, :lot_number, :string
  end
end
