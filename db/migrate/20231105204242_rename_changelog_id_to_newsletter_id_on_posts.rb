class RenameChangelogIdToNewsletterIdOnPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :changelog_id, :newsletter_id
    rename_column :sources, :changelog_id, :newsletter_id
    rename_column :updates, :changelog_id, :newsletter_id
  end
end
