class AddServiceProviderIdToUserAssociations < ActiveRecord::Migration
  def change
    add_column :user_associations, :service_provider_id, :integer
  end
end
