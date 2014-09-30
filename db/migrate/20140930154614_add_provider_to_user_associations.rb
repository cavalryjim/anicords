class AddProviderToUserAssociations < ActiveRecord::Migration
  def change
    add_column :household_associations, :provider_id, :integer
    add_column :household_associations, :provider_type, :string
    remove_column :household_associations, :service_provider_id
    remove_column :household_associations, :clinic_id
  end
end
