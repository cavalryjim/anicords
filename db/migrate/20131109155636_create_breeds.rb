class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breeds do |t|
      t.string      :name
      t.integer     :animal_type_id
      t.timestamps
    end
  end
end
