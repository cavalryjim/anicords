class CreateRegistrationClubs < ActiveRecord::Migration
  def change
    create_table :registration_clubs do |t|
      t.string      :name
      t.integer     :animal_type_id
      t.timestamps
    end
  end
end
