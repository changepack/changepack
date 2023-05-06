class ChangeNullOnCommitIdInUpdates < ActiveRecord::Migration[7.0]
  def change
    change_column_null :updates, :commit_id, true
  end
end
