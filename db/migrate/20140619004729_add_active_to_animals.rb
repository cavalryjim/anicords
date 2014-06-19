class AddActiveToAnimals < ActiveRecord::Migration
  
  def change
    add_column :animals, :active, :boolean,  default: true
    Animal.update_all(active: true)
  end
end
