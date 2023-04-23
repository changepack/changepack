class CreateChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :changes, id: :string do |t|
      t.string :message, null: false
      t.string :type, null: false
      t.belongs_to :account, index: true, foreign_key: true, type: :string
      t.belongs_to :commit, index: true, foreign_key: true, type: :string
      t.timestamps
    end

    add_index :changes, [:account_id, :commit_id], unique: true
  end
end
