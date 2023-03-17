# frozen_string_literal: true

class Repository
  module Git
    extend ActiveSupport::Concern

    include Provided

    included do
      provider :github, :id
      provider :github, :access_token
    end

    class_methods do
      def pull(git)
        return if git.nil?

        transaction do
          git.repositories.each do |repository|
            Git.upsert!(repository, git:)
          end
        end
      end

      def pull_async(git)
        Event.publish(
          Repository::Authorized.new(
            data: {
              provider: git.provider,
              access_token: git.access_token,
              account_id: git.account_id
            }
          )
        )
      end
    end

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

    def pull
      Commit.pull(self)
    end

    def cursor
      @cursor ||= commits.select { |commit| commit.commited_at > 1.month.ago }
                         .sort_by(&:commited_at)
                         .reverse
                         .pick(:commited_at)
    end

    def git
      return if providers.blank?

      @git ||= Provider[provider].new(access_token:, account_id:)
    end

    def access_token
      providers.dig(provider, :access_token)
    end
  end
end
