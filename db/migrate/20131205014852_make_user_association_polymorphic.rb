class MakeUserAssociationPolymorphic < ActiveRecord::Migration
  def change
    add_column :user_associations, :group_id, :integer
    add_column :user_associations, :group_type, :string
  end
end
