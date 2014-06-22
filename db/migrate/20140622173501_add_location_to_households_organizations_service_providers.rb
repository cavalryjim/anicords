class AddLocationToHouseholdsOrganizationsServiceProviders < ActiveRecord::Migration
  def change
    add_column :households, :latitude, :float
    add_column :households, :longitude, :float
    
    add_column :organizations, :latitude, :float
    add_column :organizations, :longitude, :float
    
    add_column :service_providers, :latitude, :float
    add_column :service_providers, :longitude, :float
  end
end
