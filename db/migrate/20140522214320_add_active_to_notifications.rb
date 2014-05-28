class AddActiveToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :active, :boolean, default: true
  end
end
