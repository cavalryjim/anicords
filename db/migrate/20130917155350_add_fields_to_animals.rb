class AddFieldsToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :dob, :date
    add_column :animals, :food, :string
    add_column :animals, :volume_per_serving, :decimal
    add_column :animals, :servings_per_day, :integer
  end
end
