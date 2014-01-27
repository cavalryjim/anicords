class AddThumbnailUrlToOrgProfile < ActiveRecord::Migration
  def change
    add_column :org_profiles, :thumbnail_url, :string
  end
end
