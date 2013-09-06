class CreateVeterinarians < ActiveRecord::Migration
  def change
    create_table :veterinarians do |t|
      t.string :clinic_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
