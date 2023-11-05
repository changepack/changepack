class RenameChangelogsToNewsletters < ActiveRecord::Migration[7.0]
  def change
    rename_table :changelogs, :newsletters
  end
end
