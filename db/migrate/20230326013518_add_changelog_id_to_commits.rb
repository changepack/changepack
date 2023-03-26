class AddChangelogIdToCommits < ActiveRecord::Migration[7.0]
  def change
    # Since `posts` used to be named `changelogs`, we're going to see
    # a `constraint for relation already exists` error so we need to
    # regenerate the foreign key.
    remove_foreign_key :commits, :posts
    add_foreign_key :commits, :posts
    add_reference :commits, :changelog, index: true, foreign_key: true, type: :string
  end
end
