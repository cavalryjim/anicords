class AddExternalImageUrlToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :external_url, :string
  end
end
