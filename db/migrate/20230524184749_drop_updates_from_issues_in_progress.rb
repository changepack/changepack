class DropUpdatesFromIssuesInProgress < ActiveRecord::Migration[7.0]
  def change
    Update
      .includes(:issue)
      .where(type: 'issue')
      .where(issues: { done: false })
      .find_each { |update| update.discard }
  end
end
