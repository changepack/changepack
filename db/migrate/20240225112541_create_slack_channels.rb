class CreateSlackChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :slack_channels, id: :string do |t|
      t.belongs_to :account, null: false, index: true, type: :string, foreign_key: true
      t.string :name, null: false
      t.string :webhook_url, null: false
      t.string :username, null: false
      t.timestamps
    end
  end
end
