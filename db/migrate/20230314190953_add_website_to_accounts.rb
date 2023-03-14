class AddWebsiteToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :website, :string
  end
end
