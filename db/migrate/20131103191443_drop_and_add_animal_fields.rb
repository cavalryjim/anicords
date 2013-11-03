class DropAndAddAnimalFields < ActiveRecord::Migration
  def change
    remove_column :animals, :shampoo
    remove_column :animals, :treat
    remove_column :animals, :vitamin
    
    add_column :animals, :shampoo_id, :integer
    add_column :animals, :treat_id, :integer
    add_column :animals, :vitamin_id, :integer
  end
end
