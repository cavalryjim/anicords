class AddSpecialInstructionsToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :special_instructions, :text
  end
end
