class AddUniqueOnUserProviderProviderIdOnRepositories < ActiveRecord::Migration[7.0]
  def change
    add_index :repositories, [:user_id, :provider, :provider_id], unique: true
  end
end
