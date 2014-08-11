class AddFieldsToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :series_name, :string
    add_column :medications, :series_number, :integer
    add_column :medications, :series_interval, :integer
    add_column :medications, :series_next_id, :integer
    add_column :medications, :recommended_dosage, :string
    add_column :medications, :animal_type_id, :integer
    add_column :medications, :frequency, :integer
    add_column :medications, :chronic, :boolean, default: false
  end
end
