class AddFileUidAndFileNameToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :file_uid,  :string
    add_column :documents, :file_name, :string
    remove_column :documents, :file_path
    rename_column :documents, :type, :file_type
  end
end
