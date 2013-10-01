class CreateServiceProviderTypes < ActiveRecord::Migration
  def change
    create_table :service_provider_types do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
