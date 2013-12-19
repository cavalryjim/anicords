class AddDueDateToAnimalVaccination < ActiveRecord::Migration
  def change
    add_column :animal_vaccinations, :vaccination_due, :date
  end
end
