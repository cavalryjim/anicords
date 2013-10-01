class AddServiceProviderTypeIdToServiceProvider < ActiveRecord::Migration
  def change
    add_column :service_providers, :service_provider_type_id, :integer
  end
end
