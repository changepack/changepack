class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens, id: :string do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false

      t.belongs_to :user, index: true, foreign_key: true, type: :string, null: false
      t.belongs_to :account, index: true, foreign_key: true, type: :string, null: false
      t.belongs_to :changelog, index: true, foreign_key: true, type: :string, null: false

      t.timestamps
    end

    add_index :access_tokens, [:account_id, :provider, :token], unique: true
  end
end
