class AddTitleToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :category, :string, null: false
    add_column :notifications, :title, :string, null: false
    add_column :notifications, :body, :string, null: false
    add_column :notifications, :summary, :string, null: false
    add_column :notifications, :data, :jsonb, default: {}, null: false
    add_column :notifications, :url, :string
    add_reference :notifications, :subject, polymorphic: true, index: true
  end
end
