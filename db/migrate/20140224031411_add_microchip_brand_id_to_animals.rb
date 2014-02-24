class AddMicrochipBrandIdToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :microchip_brand_id, :integer
    remove_column :animals, :microchip_brand
  end
end
