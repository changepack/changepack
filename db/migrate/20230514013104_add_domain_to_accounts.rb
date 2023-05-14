class AddDomainToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :domain, :string
  end
end
