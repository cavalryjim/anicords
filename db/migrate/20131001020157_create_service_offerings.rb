class CreateServiceOfferings < ActiveRecord::Migration
  def change
    create_table :service_offerings do |t|
      t.integer :service_provider_id
      t.integer :service_id
      
      t.timestamps
    end
  end
end
