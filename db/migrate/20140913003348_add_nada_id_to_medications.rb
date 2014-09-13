class AddNadaIdToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :nada_id, :string
    add_column :medications, :produced_by, :string
  end
end
