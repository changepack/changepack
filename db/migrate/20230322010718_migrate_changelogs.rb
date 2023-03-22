class MigrateChangelogs < ActiveRecord::Migration[7.0]
  def change
    Account.find_each do |account|
      account.changelogs << Changelog.new(name: account.name)
    end
  end
end
