class AddDiscardedAtToSources < ActiveRecord::Migration[7.0]
  def change
    add_column :sources, :discarded_at, :datetime
  end
end
