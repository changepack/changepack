class CreateNotificationTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_templates, id: :string do |t|
      t.string :category, null: false
      t.string :type, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :summary, null: false
      t.timestamps
    end
    add_index :notification_templates, [:type, :category], unique: true
    add_reference :notifications, :template, foreign_key: { to_table: :notification_templates }, index: true, type: :string
  end
end
