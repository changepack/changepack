class AddChangelogIdToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_reference :repositories, :changelog, index: true, foreign_key: true, type: :string
  end
end
