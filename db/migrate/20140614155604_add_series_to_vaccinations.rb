class AddSeriesToVaccinations < ActiveRecord::Migration
  def change
    add_column :vaccinations, :series_name, :string
    add_column :vaccinations, :series_number, :integer
    add_column :vaccinations, :series_interval, :integer
    add_column :vaccinations, :series_next_id, :integer
  end
end
