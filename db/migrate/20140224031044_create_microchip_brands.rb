class CreateMicrochipBrands < ActiveRecord::Migration
  def change
    create_table :microchip_brands do |t|
      t.string :name
      t.string :website
      
      t.timestamps
    end
  end
end
