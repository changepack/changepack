class CreateHooks < ActiveRecord::Migration[7.1]
  def change
    drop_table :slack_channels, id: :string do |t|
      t.string :name, null: false
      t.string :username, null: false
      t.string :webhook_url, null: false
      t.belongs_to :account, null: false, index: true, type: :string, foreign_key: true
      t.timestamps
    end

    create_table :hooks, id: :string do |t|
      t.string :provider, null: false
      t.string :direction, null: false
      t.jsonb :request, null: false, default: {}
      t.belongs_to :account, null: false, index: true, type: :string, foreign_key: true
      t.timestamps
    end
  end
end
