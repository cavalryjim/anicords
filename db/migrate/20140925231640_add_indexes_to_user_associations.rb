class AddIndexesToUserAssociations < ActiveRecord::Migration
  def change
    add_index :user_associations, :user_id
    add_index :user_associations, [:group_id, :group_type]
  end
end
