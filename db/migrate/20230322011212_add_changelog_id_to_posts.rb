class AddChangelogIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :changelog, index: true, foreign_key: true, type: :string
  end
end
