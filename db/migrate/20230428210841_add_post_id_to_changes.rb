class AddPostIdToChanges < ActiveRecord::Migration[7.0]
  def change
    add_reference :changes, :post, index: true, foreign_key: true, type: :string
    rename_column :changes, :message, :name
  end
end
