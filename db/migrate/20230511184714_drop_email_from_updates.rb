class DropEmailFromUpdates < ActiveRecord::Migration[7.0]
  def change
    remove_column :updates, :email
  end
end
