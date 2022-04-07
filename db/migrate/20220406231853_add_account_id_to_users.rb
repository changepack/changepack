class AddAccountIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference(:users, :account, index: true, foreign_key: true, type: :string)
  end
end
