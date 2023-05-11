class AddPulledAtToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :pulled_at, :datetime
  end
end
