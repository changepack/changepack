class MigrateSourceInOnUpdates < ActiveRecord::Migration[7.0]
  def change
    Update.transaction do
      Update.includes(:commit).find_each do |update|
        source = Source.find_by(repository_id: update.commit.repository_id)
        update.update!(source:)
      end
    end
  end
end
