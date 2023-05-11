class AddTagsToUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :tags, :string, default: [], null: false, array: true
  end
end
