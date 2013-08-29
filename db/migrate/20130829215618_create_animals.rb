class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :animal_type_id
      t.string :breed
      t.decimal :weight
      t.text :description
      t.integer :household_id
      t.integer :breeder_id

      t.timestamps
    end
  end
end
