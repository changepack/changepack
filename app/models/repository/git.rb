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
      def pull(git, account:)
        return if git.nil?

        transaction do
          git.repositories.each do |repository|
            Git.upsert!(repository, git:, account:)
          end
        end
      end
    end

    def self.upsert!(repository, git:, account:)
      providers = {
        git.provider => {
          id: repository.id,
          access_token: git.access_token
        }
      }

      Repository.find_or_initialize_by(account:, providers:) do |repo|
        repo.update!(repository.to_h)
      end
    end

    def pull
      Commit.pull(self)
    end

    def cursor
      @cursor ||= commits.select { |commit| commit.commited > 1.month.ago }
                         .sort_by(&:commited)
                         .reverse
                         .pick(:commited)
    end

    def git
      return if providers.blank?

      @git ||= Provider[provider].new(access_token)
    end

    def access_token
      providers.dig(provider, :access_token)
    end
  end
end
