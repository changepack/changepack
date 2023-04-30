class ChangeNullOfChangelogOnSources < ActiveRecord::Migration[7.0]
  def change
    change_column_null :sources, :changelog_id, false
    change_column_null :updates, :changelog_id, false
  end
end
