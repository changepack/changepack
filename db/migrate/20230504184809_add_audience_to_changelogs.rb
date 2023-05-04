class AddAudienceToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_column :changelogs, :audience, :string, default: :non_technical, null: false
  end
end
