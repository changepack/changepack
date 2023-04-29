class MigrateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    AccessToken.transaction do
      Repository.find_each do |repository|
        token = repository.providers[repository.provider]['access_token']
        user = User.where.contains(providers: { github: { access_token: token } }).first

        access_token = AccessToken.find_or_create_by!(
          provider: repository.provider,
          token:,
          user:
        )

        repository.update!(access_token:)
      end
    end
  end
end
