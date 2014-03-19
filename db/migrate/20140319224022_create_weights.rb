class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.float :measure_num
      t.string :measure_unit
      t.date  :measure_date
      t.integer :animal_id  
      t.timestamps
    end
  end
end
