# typed: true
class CreateChangelogs < ActiveRecord::Migration[7.0]
  def change
    create_table :changelogs, id: :string do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
