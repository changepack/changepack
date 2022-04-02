class AddStatusToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :status, :string, default: 'draft', null: false
  end
end
