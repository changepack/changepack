class RenameChangelogsToPosts < ActiveRecord::Migration[7.0]
  def change
    rename_table :changelogs, :posts
    rename_table :changelog_transitions, :post_transitions

    rename_column :post_transitions, :changelog_id, :post_id
    rename_column :commits, :changelog_id, :post_id
  end
end
