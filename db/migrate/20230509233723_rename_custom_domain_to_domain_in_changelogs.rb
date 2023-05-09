class RenameCustomDomainToDomainInChangelogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :changelogs, :custom_domain, :domain
  end
end
