class AddSlugToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :slug, :string
    add_index :changelogs, :slug, unique: true
  end
end
