class RenameExternalIdsToProviderIdsInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :external_ids, :provider_ids
  end
end
