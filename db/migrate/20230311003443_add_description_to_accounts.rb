class AddDescriptionToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :description, :string
  end
end
