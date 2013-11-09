class DropAnimalFood < ActiveRecord::Migration
  def change
    drop_table :animal_foods
    
    add_column :animals, :food_id, :integer
  end
end
