class AddVeterinarianIdToUserAssociations < ActiveRecord::Migration
  def change
    add_column :user_associations, :veterinarian_id, :integer
  end
end
