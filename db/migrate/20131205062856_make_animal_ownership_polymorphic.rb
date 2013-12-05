class MakeAnimalOwnershipPolymorphic < ActiveRecord::Migration
  def change
    add_column :animals, :owner_id, :integer
    add_column :animals, :owner_type, :string
  end
end
