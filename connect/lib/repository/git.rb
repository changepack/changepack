# typed: false
# frozen_string_literal: true

class Repository
  module Git
    extend ActiveSupport::Concern
    extend T::Sig

    include Provided

    included do
      provider :github
    end

    class_methods do
      extend T::Sig

      sig { params(git: Provider).returns(T::Boolean) }
      def pull(git)
        transaction do
          git.repositories.each do |repository|
            Git.upsert!(repository, git:)
          end
        end

        true
      end

      sig { params(git: Provider).returns(T::Boolean) }
      def pull_async(git)
        Event.publish(
          Repository::Authorized.new(
            access_token: git.access_token.to_s,
            account_id: git.account_id,
            provider: git.provider
          )
        )

        true
      end
    end

    sig { params(repository: Provider::Repository, git: Provider).returns(Repository) }
    def self.upsert!(repository, git:)
      account_id = git.account_id
      providers = {
        git.provider => { id: repository.id, access_token: git.access_token.to_s }
      }

      Repository.lock.find_or_initialize_by(account_id:, providers:) do |repo|
        repo.update!(repository.to_h)
      end
    end

    sig { returns T::Boolean }
    def pull
      Commit.pull(self)
    end

    sig { returns T.nilable(Integer) }
    def cursor
      @cursor ||= commits.select { |commit| commit.commited_at > 1.month.ago }
                         .sort_by(&:commited_at)
                         .reverse
                         .pick(:commited_at)
                         .try(:to_i)
    end

    sig { returns Provider }
    def git
      @git ||= Provider[provider].new(access_token:, account_id:)
    end
  end
end
