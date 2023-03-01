# frozen_string_literal: true

class Repository
  module Pull
    extend ActiveSupport::Concern

    included do
      def self.pull(git, account:)
        return if git.nil?

        transaction do
          git.repositories.each do |repository|
            Pull.upsert!(repository, git:, account:)
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
  end
end
