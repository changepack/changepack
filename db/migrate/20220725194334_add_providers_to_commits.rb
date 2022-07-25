class AddProvidersToCommits < ActiveRecord::Migration[7.0]
  def up
    add_column :commits, :providers, :jsonb, default: {}, null: false

    Commit.find_each do |commit|
      commit.update!(providers: { commit.attributes['provider'] => commit.provider_id })
    end

    remove_column :commits, :provider
    remove_column :commits, :provider_id
  end

  def down
    add_column :commits, :provider, :string
    add_column :commits, :provider_id, :string

    Commit.find_each do |commit|
      commit.update!(
        provider: commit.providers.keys.first,
        provider_id: commit.providers.values.first
      )
    end

    remove_column :commits, :providers

    change_column_null :commits, :provider, false
    change_column_null :commits, :provider_id, false
  end
end
