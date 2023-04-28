class AddDiscardedAtToUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :discarded_at, :datetime
  end
end
