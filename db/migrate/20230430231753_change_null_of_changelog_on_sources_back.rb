class ChangeNullOfChangelogOnSourcesBack < ActiveRecord::Migration[7.0]
  def change
    change_column_null :sources, :changelog_id, true
    change_column_null :updates, :changelog_id, true
  end
end
