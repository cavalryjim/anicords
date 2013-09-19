class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :file_path
      t.integer :animal_id

      t.timestamps
    end
  end
end
