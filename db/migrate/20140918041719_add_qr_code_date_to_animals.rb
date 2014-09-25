class AddQrCodeDateToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :qr_code_date, :date
  end
end
