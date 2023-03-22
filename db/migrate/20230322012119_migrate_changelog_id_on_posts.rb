class MigrateChangelogIdOnPosts < ActiveRecord::Migration[7.0]
  def change
    Post.includes(account: :changelogs).find_each do |post|
      post.changelog_id = post.account.changelogs.first.id
      post.save!
    end
  end
end
