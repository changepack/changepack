class RenameProviderIdsToProviders < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :provider_ids, :providers
  end
end
