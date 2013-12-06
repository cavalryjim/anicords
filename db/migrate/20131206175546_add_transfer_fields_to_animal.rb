class AddTransferFieldsToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :pending_transfer, :boolean
  end
end
