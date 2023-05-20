class CreateAPIKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys, id: :string do |t|
      t.references :account, null: false, foreign_key: true, type: :string
      t.string :token, null: false
      t.datetime :last_used_at
      t.index :token, unique: true
      t.timestamps
    end
  end
end
