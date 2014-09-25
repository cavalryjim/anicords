class AddIndexAnimalOwner < ActiveRecord::Migration
  def change
    add_index :animals, [:owner_id, :owner_type]
  end
end
