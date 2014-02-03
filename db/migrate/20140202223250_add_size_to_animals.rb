class AddSizeToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :size, :string
  end
end
