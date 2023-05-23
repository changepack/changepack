class AddSourcedAtToUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :sourced_at, :datetime
  end
end
