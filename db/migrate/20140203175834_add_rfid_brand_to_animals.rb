class AddRfidBrandToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :rfid_brand, :string
  end
end
