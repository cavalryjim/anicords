class CreatePersonalityTypes < ActiveRecord::Migration
  def change
    create_table :personality_types do |t|
      t.string      :name
      t.integer     :animal_type_id
      t.timestamps
    end
  end
end
