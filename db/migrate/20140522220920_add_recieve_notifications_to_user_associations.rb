class AddRecieveNotificationsToUserAssociations < ActiveRecord::Migration
  def change
    add_column :user_associations, :receive_notifications, :boolean, default: true
  end
end
