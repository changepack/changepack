class RemoveAboutAudienceFromChangelogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :changelogs, :about_audience
  end
end
