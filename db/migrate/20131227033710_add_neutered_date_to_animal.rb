class AddNeuteredDateToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :neutered_date, :date
  end
end
