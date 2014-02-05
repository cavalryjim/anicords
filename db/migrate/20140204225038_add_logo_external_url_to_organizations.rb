class AddLogoExternalUrlToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :logo_external_url, :string
  end
end
