class AddDiscardedToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :discarded, :datetime
    add_index :changelogs, :discarded

    add_column :accounts, :discarded, :datetime
    add_index :accounts, :discarded

    add_column :commits, :discarded, :datetime
    add_index :commits, :discarded

    add_column :repositories, :discarded, :datetime
    add_index :repositories, :discarded

    add_column :users, :discarded, :datetime
    add_index :users, :discarded
  end
end
