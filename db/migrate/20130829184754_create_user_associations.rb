class CreateUserAssociations < ActiveRecord::Migration
  def change
    create_table :user_associations do |t|
      t.integer :user_id
      t.integer :breeder_id
      t.integer :household_id
      t.boolean :administrator

      t.timestamps
    end
  end
end
