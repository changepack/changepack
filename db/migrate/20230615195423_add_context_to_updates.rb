class AddContextToUpdates < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :context, :text
  end
end
