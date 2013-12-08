class AddEventToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :event_id, :integer
    add_column :notifications, :event_type, :string
  end
end
