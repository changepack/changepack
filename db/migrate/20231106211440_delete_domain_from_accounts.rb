class DeleteDomainFromAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :domain, :string
  end
end
