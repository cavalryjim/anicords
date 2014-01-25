class CreateOrganizationLocations < ActiveRecord::Migration
  def change
    drop_table :foster_homes if self.table_exists?("foster_homes")
    
    create_table :organization_locations do |t|
      t.integer       :organization_id
      t.references    :location, polymorphic: true  
      t.timestamps
    end
  end
end
