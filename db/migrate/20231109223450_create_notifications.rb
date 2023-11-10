class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :string do |t|
      t.string :type, null: false
      t.string :channels, array: true, default: ['email', 'web'], null: false
      t.references :account, foreign_key: true, type: :string, null: false
      t.timestamps
    end
  end
end
