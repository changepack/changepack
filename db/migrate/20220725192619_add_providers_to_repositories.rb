class AddProvidersToRepositories < ActiveRecord::Migration[7.0]
  def up
    add_column :repositories, :providers, :jsonb, default: {}, null: false

    Repository.find_each do |repository|
      repository.update!(providers: { repository.attributes['provider'] => repository.provider_id })
    end

    remove_column :repositories, :provider
    remove_column :repositories, :provider_id
  end

  def down
    add_column :repositories, :provider, :string
    add_column :repositories, :provider_id, :string

    Repository.find_each do |repository|
      repository.update!(
        provider: repository.providers.keys.first,
        provider_id: repository.providers.values.first
      )
    end

    remove_column :repositories, :providers

    change_column_null :repositories, :provider, false
    change_column_null :repositories, :provider_id, false
  end
end
