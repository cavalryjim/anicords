class AddImageUidToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_uid,  :string
    add_column :pictures, :image_name, :string
    remove_column :pictures, :image
  end
end
