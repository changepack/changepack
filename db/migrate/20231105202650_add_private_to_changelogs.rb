class AddPrivateToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :private, :boolean, default: true
    remove_column :changelogs, :privacy
  end
end
