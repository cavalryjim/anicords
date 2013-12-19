class AddAnimalTypeIdToVaccinations < ActiveRecord::Migration
  def change
    add_column :vaccinations, :animal_type_id, :integer
  end
end
