class AddTagNumberToAnimalVaccination < ActiveRecord::Migration
  def change
    add_column :animal_vaccinations, :tag_number,  :string
  end
end
