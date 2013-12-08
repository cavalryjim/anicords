class RemoveUnusedFieldsFromUserAssociation < ActiveRecord::Migration
  def change
    remove_column :user_associations, :household_id
    remove_column :user_associations, :service_provider_id
    remove_column :user_associations, :breeder_id
    remove_column :user_associations, :veterinarian_id 
    
  end
end
