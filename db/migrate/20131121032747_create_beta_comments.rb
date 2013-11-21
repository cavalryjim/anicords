class CreateBetaComments < ActiveRecord::Migration
  def change
    create_table :beta_comments do |t|
      t.text :comment
      t.string :page_url
      t.integer :user_id
      t.timestamps
    end
  end
end
