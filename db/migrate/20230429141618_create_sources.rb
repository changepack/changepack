class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources, id: :string do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.references :account, null: false, foreign_key: true, type: :string
      t.references :repository, foreign_key: true, type: :string
      t.timestamps
    end
  end
end
