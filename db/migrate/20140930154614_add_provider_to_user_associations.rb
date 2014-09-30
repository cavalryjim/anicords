class AddProviderToUserAssociations < ActiveRecord::Migration
  def change
    add_column :household_associations, :provider_id, :integer
    add_column :household_associations, :provider_type, :string
    
    remove_column :household_associations, :service_provider_id if column_exists?(:household_associations, :service_provider_id)
    remove_column :household_associations, :clinic_id if column_exists?(:household_associations, :clinic_id)
    
    add_index :household_associations, :household_id
    add_index :household_associations, [:provider_id, :provider_type]
  end
end
