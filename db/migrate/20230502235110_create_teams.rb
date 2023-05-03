class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: :string do |t|
      t.string :name, null: false
      t.string :status, default: :inactive, null: false
      t.jsonb :providers, default: {}, null: false
      t.datetime :discarded_at
      t.belongs_to :account, null: false, foreign_key: true, type: :string
      t.belongs_to :access_token, foreign_key: true, type: :string
      t.index :providers, unique: true
      t.timestamps
    end
  end
end
