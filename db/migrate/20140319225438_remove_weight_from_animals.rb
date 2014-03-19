class RemoveWeightFromAnimals < ActiveRecord::Migration
  def change
    remove_column :animals, :weight
    remove_column :animals, :weight_measure
  end
end
