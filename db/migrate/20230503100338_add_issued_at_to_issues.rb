class AddIssuedAtToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :issued_at, :datetime, null: false
  end
end
