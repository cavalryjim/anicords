class CreateDispositions < ActiveRecord::Migration
  def change
    create_table :dispositions do |t|
      t.integer     :animal_id
      t.integer     :personality_type_id
      t.timestamps
    end
  end
end
