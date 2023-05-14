class DropDomainFromChangelogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :changelogs, :domain, :string
  end
end
