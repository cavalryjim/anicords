class AddExternalUrlToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :external_url, :string
  end
end
