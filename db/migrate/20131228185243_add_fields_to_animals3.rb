class AddFieldsToAnimals3 < ActiveRecord::Migration
  def change
    add_column :animals, :fur_color, :string
    add_column :animals, :disposition, :string
  end
end
