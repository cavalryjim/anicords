class AddAnimalIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :animal_id, :integer
  end
end
