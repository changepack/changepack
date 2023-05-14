class AddPrivacyToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :privacy, :string, null: false, default: 'public'
  end
end
