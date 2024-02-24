class RenameContextToDescriptionInUpdates < ActiveRecord::Migration[7.1]
  def change
    rename_column :updates, :context, :description
  end
end
