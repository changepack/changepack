class MigrateSourcesFromRepositories < ActiveRecord::Migration[7.0]
  def change
    Source.transaction do
      Repository.find_each do |repository|
        Source.create!(
          type: :repository,
          account_id: repository.account_id,
          repository_id: repository.id,
          name: repository.name
        )
      end
    end
  end
end
