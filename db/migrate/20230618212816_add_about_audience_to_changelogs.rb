class AddAboutAudienceToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :about_audience, :text
  end
end
