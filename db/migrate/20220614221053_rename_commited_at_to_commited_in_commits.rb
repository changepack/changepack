class RenameCommitedAtToCommitedInCommits < ActiveRecord::Migration[7.0]
  def change
    rename_column :commits, :commited_at, :commited
  end
end
