class CreateForbiddens < ActiveRecord::Migration[7.0]
  def change
    create_table :forbiddens, id: :string do |t|
      t.string :type, null: false
      t.string :content, null: false
      t.belongs_to :changelog, index: true, null: false
      t.index [:changelog_id, :type, :content], unique: true
      t.timestamps
    end
  end
end
