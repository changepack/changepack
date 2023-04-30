class AddSourceIdToUpdates < ActiveRecord::Migration[7.0]
  def change
    add_reference :updates, :source, index: true, foreign_key: true, type: :string
  end
end
