class AddServiceProviderTypeIdToService < ActiveRecord::Migration
  def change
    add_column :services, :service_provider_type_id, :integer
  end
end
