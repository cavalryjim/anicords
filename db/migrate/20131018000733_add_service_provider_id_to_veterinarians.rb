class AddServiceProviderIdToVeterinarians < ActiveRecord::Migration
  def change
    add_column :veterinarians, :service_provider_id, :integer
  end
end
