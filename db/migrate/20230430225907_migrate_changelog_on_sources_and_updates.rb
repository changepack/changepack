class MigrateChangelogOnSourcesAndUpdates < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.transaction do
      Source.find_each do |source|
        changelog = Changelog.find_by(account_id: source.account_id)
        source.update!(changelog: changelog)
      end

      Update.find_each do |update|
        changelog = Changelog.find_by(account_id: update.account_id)
        update.update!(changelog: changelog)
      end
    end
  end
end
