class RenameUserIdToRecipientIdInNotificationDeliveries < ActiveRecord::Migration[7.1]
  def change
    rename_column :notification_deliveries, :user_id, :recipient_id
    add_column :notification_deliveries, :recipient_type, :string

    # Update all existing records to have recipient_type 'User'
    Notification::Delivery.update_all(recipient_type: 'User')

    add_index :notification_deliveries, [:recipient_type, :recipient_id]
  end
end
