class RemoveAudienceFromNewsletters < ActiveRecord::Migration[7.0]
  def change
    remove_column :newsletters, :audience
    add_column :newsletters, :audience, :string
  end
end
