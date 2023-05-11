class ChangeNullOnAssigneeInIssues < ActiveRecord::Migration[7.0]
  def change
    change_column_null :issues, :assignee, true
  end
end
