class CreateUsageStatistics < ActiveRecord::Migration
  def change
    create_table :usage_statistics do |t|
      t.integer :users
      t.integer :animals
      t.integer :households
      t.integer :organizations
      t.integer :service_providers
        
      t.timestamps
    end
  end
end
