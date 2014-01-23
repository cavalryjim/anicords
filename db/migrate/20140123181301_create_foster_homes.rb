class CreateFosterHomes < ActiveRecord::Migration
  def change
    create_table :foster_homes do |t|
      t.integer     :household_id
      t.integer     :organization_id
      t.timestamps
    end
  end
end
