class RenameForbiddensToBannedItems < ActiveRecord::Migration[7.0]
  def change
    rename_table :forbiddens, :banned_items
  end
end
