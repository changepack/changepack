class AddSchemaToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :schema, :jsonb, default: {}, null: false
  end
end
