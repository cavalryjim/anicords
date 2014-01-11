class AddAvatarToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :avatar_uid,  :string
    add_column :animals, :avatar_name, :string
    remove_column :animals, :avatar
  end
end
