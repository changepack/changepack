class AddCustomDomainToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :custom_domain, :string
  end
end
