class ChangeNullOnSourcedAtInUpdates < ActiveRecord::Migration[7.0]
  def change
    change_column_null :updates, :sourced_at, false
  end
end
