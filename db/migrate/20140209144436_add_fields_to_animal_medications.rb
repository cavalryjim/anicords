class AddFieldsToAnimalMedications < ActiveRecord::Migration
  def change
    add_column :animal_medications, :volume, :string
    add_column :animal_medications, :route, :string
    add_column :animal_medications, :interval, :string
  end
end
