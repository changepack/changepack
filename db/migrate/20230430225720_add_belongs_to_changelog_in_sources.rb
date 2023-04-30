class AddBelongsToChangelogInSources < ActiveRecord::Migration[7.0]
  def change
    add_reference :sources, :changelog, foreign_key: true, type: :string
  end
end
