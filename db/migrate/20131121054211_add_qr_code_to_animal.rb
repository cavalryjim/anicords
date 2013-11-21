class AddQrCodeToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :qr_code_uid,  :string
    add_column :animals, :qr_code_name, :string
  end
end
