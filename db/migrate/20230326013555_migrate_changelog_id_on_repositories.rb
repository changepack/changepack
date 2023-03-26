class MigrateChangelogIdOnRepositories < ActiveRecord::Migration[7.0]
  def change
    Repository.includes(account: :changelogs).find_each do |repository|
      repository.changelog_id = repository.account.changelogs.first.id
      repository.save!
    end
  end
end
