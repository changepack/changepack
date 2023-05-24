class MigratePublishedAtOnPosts < ActiveRecord::Migration[7.0]
  def change
    Post.where(published_at: nil, status: :published).find_each do |post|
      post.update(published_at: post.created_at)
    end
  end
end
