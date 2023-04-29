class MigrateStatusOnSources < ActiveRecord::Migration[7.0]
  def change
    Source.transaction do
      Source.includes(:repository).find_each do |source|
        source.update!(status: :active) if source.repository.status.active?
      end
    end
  end
end
