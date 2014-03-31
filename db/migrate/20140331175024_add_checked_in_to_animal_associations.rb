class AddCheckedInToAnimalAssociations < ActiveRecord::Migration
  def change
    add_column :animal_associations, :checked_in, :boolean
  end
end
