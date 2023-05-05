class CreateForbiddens < ActiveRecord::Migration[7.0]
  def change
    create_table :forbiddens, id: :string do |t|
      t.string :type, null: false
      t.string :content, null: false
      t.belongs_to :source, index: true, null: false, type: :string, foreign_key: true
      t.index [:source_id, :type, :content], unique: true
      t.timestamps
    end
  end
end
