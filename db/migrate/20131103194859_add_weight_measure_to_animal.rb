class AddWeightMeasureToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :weight_measure, :string
  end
end
