class ReferenceChangelogInCommits < ActiveRecord::Migration[7.0]
  def change
    add_reference(:commits, :changelog, index: true, foreign_key: true, type: :string)
  end
end