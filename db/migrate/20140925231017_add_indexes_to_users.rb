class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, [:uid, :provider]
  end
end
