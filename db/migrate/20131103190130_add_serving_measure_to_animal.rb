class AddServingMeasureToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :serving_measure, :string
  end
end
