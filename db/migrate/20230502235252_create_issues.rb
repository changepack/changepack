class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues, id: :string do |t|
      t.string :title, null: false
      t.text :description
      t.jsonb :assignee, default: {}, null: false
      t.jsonb :providers, default: {}, null: false
      t.string :branch
      t.string :identifier
      t.string :labels, default: [], null: false, array: true
      t.decimal :priority
      t.boolean :done, null: false, default: false
      t.datetime :discarded_at
      t.belongs_to :account, null: false, foreign_key: true, type: :string
      t.belongs_to :team, null: false, foreign_key: true, type: :string
      t.index :providers, unique: true
      t.timestamps
    end
  end
end
