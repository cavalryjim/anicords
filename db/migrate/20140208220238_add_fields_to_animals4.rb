class AddFieldsToAnimals4 < ActiveRecord::Migration
  def change
    add_column :animals, :pedigreed, :boolean
    add_column :animals, :microchipped, :boolean
    add_column :animals, :neuter_location, :string
    rename_column :animals, :rfid, :microchip_id
    rename_column :animals, :rfid_brand, :microchip_brand
  end
end
