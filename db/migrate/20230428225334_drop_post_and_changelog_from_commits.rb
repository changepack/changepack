class DropPostAndChangelogFromCommits < ActiveRecord::Migration[7.0]
  def change
    remove_column :commits, :post_id, :string
    remove_column :commits, :changelog_id, :string
  end
end
