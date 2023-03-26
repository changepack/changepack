class ChangeColumnNullOnChangelogIdInCommits < ActiveRecord::Migration[7.0]
  def change
    change_column_null :commits, :changelog_id, false
    change_column_null :commits, :account_id, false
    change_column_null :commits, :repository_id, false

    change_column_null :changelogs, :account_id, false

    change_column_null :posts, :account_id, false
    change_column_null :posts, :changelog_id, false

    change_column_null :repositories, :account_id, false
    change_column_null :repositories, :changelog_id, false

    change_column_null :users, :account_id, false
  end
end
