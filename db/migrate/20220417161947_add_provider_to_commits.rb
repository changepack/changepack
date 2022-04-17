class AddProviderToCommits < ActiveRecord::Migration[7.0]
  def change
    add_column :commits, :provider, :string, null: false
    add_column :commits, :provider_id, :string, null: false
    add_index :commits, [:repository_id, :provider, :provider_id], unique: true
  end
end
