class AddDiscardedAtToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :discarded_at, :datetime
  end
end
