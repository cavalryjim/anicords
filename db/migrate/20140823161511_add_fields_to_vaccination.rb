class AddFieldsToVaccination < ActiveRecord::Migration
  def change
    add_column :vaccinations, :vaccination_type, :string
    add_column :vaccinations, :vaccination_subtype, :string
    add_column :vaccinations, :route, :string
    add_column :vaccinations, :produced_by, :string
  end
end
