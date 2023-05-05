class ChangeEmailNullOnUpdates < ActiveRecord::Migration[7.0]
  def change
    change_column_null :updates, :email, false
  end
end
