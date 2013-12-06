class CreateAnimalTransfers < ActiveRecord::Migration
  def change
    create_table :animal_transfers do |t|
      t.belongs_to :animal
      t.references :transferee, polymorphic: true
      t.timestamps
    end
  end
end
