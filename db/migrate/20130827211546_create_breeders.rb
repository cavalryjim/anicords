class CreateBreeders < ActiveRecord::Migration
  def change
    create_table :breeders do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :email

      t.timestamps
    end
  end
end
