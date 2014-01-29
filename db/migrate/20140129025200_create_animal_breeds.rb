class CreateAnimalBreeds < ActiveRecord::Migration
  def change
    remove_column :animals, :breed_id
    create_table :animal_breeds do |t|
      t.integer     :animal_id
      t.integer     :breed_id
      t.timestamps
    end
  end
end
