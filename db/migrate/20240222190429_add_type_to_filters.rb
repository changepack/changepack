class AddTypeToFilters < ActiveRecord::Migration[7.1]
  def change
    add_column :filters, :type, :string, null: false, default: 'reject'
  end
end
