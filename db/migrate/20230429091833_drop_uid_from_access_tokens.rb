class DropUidFromAccessTokens < ActiveRecord::Migration[7.0]
  def change
    remove_column :access_tokens, :uid, :string
    remove_column :access_tokens, :changelog_id, :string
    add_reference :repositories, :access_token, index: true, foreign_key: true, type: :string
  end
end
