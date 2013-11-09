class DropAndAddAnimalFields2 < ActiveRecord::Migration
  def change
    remove_column :animals, :breed
    
    add_column :animals, :breed_id, :integer
    add_column :animals, :gender, :string
    add_column :animals, :neutered, :boolean
    
  end
end
