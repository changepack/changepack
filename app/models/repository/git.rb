# typed: false
# frozen_string_literal: true

class Repository
  module Git
    extend ActiveSupport::Concern
    extend T::Sig

    include Provided

    included do
      provider :github, :id
      provider :github, :access_token
    end

    class_methods do
      extend T::Sig

      sig { params(git: T.nilable(Provider)).returns(T::Boolean) }
      def pull(git)
        return false if git.nil?

        transaction do
          git.repositories.each do |repository|
            Git.upsert!(repository, git:)
          end
        end

        true
      end

      sig { params(git: T.nilable(Provider)).returns(T::Boolean) }
      def pull_async(git)
        return false if git.nil?

        Event.publish(
          Repository::Authorized.new(
            data: { provider: git.provider, access_token: git.access_token, account_id: git.account_id }
          )
        )

        true
      end
    end

    sig { params(repository: Provider::Repository, git: T.nilable(Provider)).returns(Repository) }
    def self.upsert!(repository, git:)
      account_id = git.account_id
      providers = {
        git.provider => {
          id: repository.id,
          access_token: git.access_token
        }
      }

      Repository.find_or_initialize_by(account_id:, providers:) do |repo|
        repo.update!(repository.to_h)
      end
    end

    sig { returns T::Boolean }
    def pull
      Commit.pull(self)
    end

    sig { returns T.nilable(ActiveSupport::TimeWithZone) }
    def cursor
      @cursor ||= commits.select { |commit| commit.commited_at > 1.month.ago }
                         .sort_by(&:commited_at)
                         .reverse
                         .pick(:commited_at)
    end

    sig { returns T.nilable(Provider) }
    def git
      return if providers.blank?

      @git ||= Provider[provider].new(access_token:, account_id:)
    end

    sig { returns String }
    def access_token
      providers.dig(provider, :access_token)
    end
  end
end
