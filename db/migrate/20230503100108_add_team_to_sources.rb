class AddTeamToSources < ActiveRecord::Migration[7.0]
  def change
    add_reference :sources, :team, type: :string
    add_reference :updates, :issue, type: :string
  end
end
