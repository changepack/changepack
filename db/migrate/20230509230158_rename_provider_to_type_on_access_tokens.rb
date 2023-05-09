class RenameProviderToTypeOnAccessTokens < ActiveRecord::Migration[7.0]
  def change
    rename_column :access_tokens, :provider, :type
  end
end
