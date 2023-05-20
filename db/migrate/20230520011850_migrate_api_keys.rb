class MigrateAPIKeys < ActiveRecord::Migration[7.0]
  def change
    Account.find_each do |account|
      account.api_keys.create!
    end
  end
end
