class AddLocationToAnimalVacconToAnimalVaccinations < ActiveRecord::Migration
  def change
    add_column :animal_vaccinations, :location, :string
  end
end
