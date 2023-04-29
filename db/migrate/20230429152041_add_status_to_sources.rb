class AddStatusToSources < ActiveRecord::Migration[7.0]
  def change
    add_column :sources, :status, :string, default: :inactive
  end
end
