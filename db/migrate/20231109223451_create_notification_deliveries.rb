class CreateNotificationDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_deliveries, id: :string do |t|
      t.references :notification, foreign_key: true, type: :string, null: false
      t.references :user, foreign_key: true, type: :string, null: false
      t.datetime :queued_at
      t.datetime :sent_at
      t.string :channel, null: false
      t.timestamps
    end
  end
end
