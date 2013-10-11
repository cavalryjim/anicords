class CreateBusinessTypes < ActiveRecord::Migration
  def change
    create_table :business_types do |t|
      t.integer :service_provider_id
      t.integer :service_provider_type_id
      
      t.timestamps
    end
  end
  
  
end
