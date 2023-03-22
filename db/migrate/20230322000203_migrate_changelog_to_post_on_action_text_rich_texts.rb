class MigrateChangelogToPostOnActionTextRichTexts < ActiveRecord::Migration[7.0]
  def change
    ActionText::RichText.where(record_type: 'Changelog').update_all(record_type: 'Post')
  end
end
