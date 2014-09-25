class AddMicrochipIndexToAnimals < ActiveRecord::Migration
  def change
    add_index :animals, :microchip_id
  end
end
