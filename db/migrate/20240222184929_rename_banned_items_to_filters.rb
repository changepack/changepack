class RenameBannedItemsToFilters < ActiveRecord::Migration[7.1]
  def change
    rename_table :banned_items, :filters
  end
end
