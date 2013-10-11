class RemoveServiceProviderIdFromServiceProvider < ActiveRecord::Migration
  def change
    remove_column :service_providers, :service_provider_type_id
  end
end
