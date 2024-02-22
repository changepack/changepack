class RenameTypeToTraitsInFilters < ActiveRecord::Migration[7.1]
  def change
    rename_column :filters, :type, :trait
  end
end
