class AddBelongsToChangelogInUpdates < ActiveRecord::Migration[7.0]
  def change
    add_reference :updates, :changelog, foreign_key: true, type: :string
  end
end
