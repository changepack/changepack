class RenameChangesToUpdates < ActiveRecord::Migration[7.0]
  def change
    rename_table :changes, :updates
  end
end
