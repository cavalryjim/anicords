class AddFieldsToAnimals2 < ActiveRecord::Migration
  def change
    add_column :animals, :image, :string
    add_column :animals, :pedigree, :string
    add_column :animals, :pedigree_chart, :string
    add_column :animals, :health_certification, :string
    add_column :animals, :vaccination_record, :string
    add_column :animals, :show_name, :string
    add_column :animals, :registration_number, :string
    add_column :animals, :shampoo, :string
    add_column :animals, :vitamin, :string
    add_column :animals, :treat, :string
  end
end
