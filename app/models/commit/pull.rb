# frozen_string_literal: true

class Commit
  module Pull
    extend ActiveSupport::Concern

    included do
      def self.pull(repository)
        return if repository.git.blank?

        transaction do
          source = Pull.source(repository)
          repository.git
                    .commits(source, after: repository.cursor)
                    .each { |commit| Pull.upsert!(commit, repository:) }

          repository.update!(pulled: Time.current)
        end
      end
    end

    def self.upsert!(commit, repository:)
      providers = { repository.provider => commit.sha }

      Commit.find_or_initialize_by(repository:, providers:) do |record|
        attributes = commit.to_h.merge(account: repository.account)
        record.update!(attributes)
      end
    end

    def self.source(repository)
      case repository.provider
      when 'github'
        repository.github_id
      end
    end
  end
end
