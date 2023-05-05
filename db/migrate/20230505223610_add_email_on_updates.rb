class AddEmailOnUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :email, :string
  end
end
