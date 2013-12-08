class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true
      t.string :message
      t.string :url
      t.timestamps
    end
  end
end
