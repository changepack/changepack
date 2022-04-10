class AddExternalIdsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :external_ids, :jsonb, default: {}
  end
end
