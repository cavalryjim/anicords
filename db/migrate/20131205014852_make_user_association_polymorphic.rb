class MakeUserAssociationPolymorphic < ActiveRecord::Migration
  def change
    add_column :user_associations, :groupable_id, :integer
    add_column :user_associations, :groupable_type, :string
  end
end
