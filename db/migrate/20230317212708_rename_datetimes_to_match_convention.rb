class RenameDatetimesToMatchConvention < ActiveRecord::Migration[7.0]
  def change
    rename_column :accounts, :discarded, :discarded_at
    rename_column :changelogs, :discarded, :discarded_at
    rename_column :commits, :commited, :commited_at
    rename_column :commits, :discarded, :discarded_at
    rename_column :repositories, :discarded, :discarded_at
  end
end
