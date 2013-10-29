class CreateVaccinations < ActiveRecord::Migration
  def change
    create_table :vaccinations do |t|
      t.string :name
      t.string :frequency
      t.string :recommended_dosage
      t.timestamps
    end
  end
end
