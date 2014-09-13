class AddFields2ToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :description, :text
    add_column :medications, :side_effects, :text
    add_column :medications, :route, :string unless column_exists?(:medications, :route)
  end
end
