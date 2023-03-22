class CreateChangelogsAgain < ActiveRecord::Migration[7.0]
  def change
    create_table :changelogs, id: :string do |t|
      t.string :name
      t.string :slug, null: false, unique: true
      t.belongs_to :account, index: true, foreign_key: true, type: :string
      t.timestamps
    end
  end
end
