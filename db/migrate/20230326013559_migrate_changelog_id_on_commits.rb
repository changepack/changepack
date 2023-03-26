class MigrateChangelogIdOnCommits < ActiveRecord::Migration[7.0]
  def change
    Commit.includes(account: :changelogs).find_each do |commit|
      commit.changelog_id = commit.account.changelogs.first.id
      commit.save!
    end
  end
end
