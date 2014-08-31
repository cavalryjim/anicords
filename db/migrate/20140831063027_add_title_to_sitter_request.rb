class AddTitleToSitterRequest < ActiveRecord::Migration
  def change
    add_column :sitter_requests, :title, :string
  end
end
