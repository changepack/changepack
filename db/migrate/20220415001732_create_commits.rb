class CreateCommits < ActiveRecord::Migration[7.0]
  def change
    create_table :commits, id: :string do |t|
      t.text :message, null: false
      t.string :url, null: false
      t.datetime :commited_at, null: false
      t.jsonb :author, default: {}, null: false
      t.belongs_to :account, index: true, foreign_key: true, type: :string
      t.belongs_to :repository, index: true, foreign_key: true, type: :string
      t.timestamps
    end
  end
end
