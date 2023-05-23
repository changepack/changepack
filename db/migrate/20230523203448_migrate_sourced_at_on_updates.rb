class MigrateSourcedAtOnUpdates < ActiveRecord::Migration[7.0]
  def change
    Update.where(sourced_at: nil).includes(:commit, :issue).find_each do |update|
      update.update!(sourced_at: update.commit&.commited_at || update.issue&.issued_at)
    end
  end
end
