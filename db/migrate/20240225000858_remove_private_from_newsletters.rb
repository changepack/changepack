class RemovePrivateFromNewsletters < ActiveRecord::Migration[7.1]
  def change
    remove_column :newsletters, :private, :boolean, default: true
  end
end
