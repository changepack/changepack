class DropChangelogFromRepositories < ActiveRecord::Migration[7.0]
  def change
    remove_column :repositories, :changelog_id, :string
  end
end
