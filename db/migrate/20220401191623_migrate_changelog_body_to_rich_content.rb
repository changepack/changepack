class MigrateChangelogBodyToRichContent < ActiveRecord::Migration[7.0]
  def change
    remove_column :changelogs, :body, :string
  end
end
