class AddRfidToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :rfid, :string
  end
end
