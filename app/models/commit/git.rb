# typed: false
# frozen_string_literal: true

class Commit
  module Git
    extend ActiveSupport::Concern
    extend T::Sig

    include Provided

    included do
      provider :github
    end

    class_methods do
      extend T::Sig

      sig { params(repository: Repository).returns(T::Boolean) }
      def pull(repository)
        return false if repository.git.blank?

        transaction do
          source = Git.source(repository)
          repository.git
                    .commits(source, after: repository.cursor)
                    .each { |commit| Git.upsert!(commit, repository:) }

          repository.update!(pulled: Time.current)
        end

        true
      end
    end

    sig { params(commit: Provider::Commit, repository: Repository).returns(Commit) }
    def self.upsert!(commit, repository:)
      providers = { repository.provider => commit.sha }

      Commit.find_or_initialize_by(repository:, providers:) do |record|
        attributes = commit.to_h.merge(account: repository.account)
        record.update!(attributes)
      end
    end

    sig { params(repository: Repository).returns(T.nilable(T::Integer)) }
    def self.source(repository)
      case repository.provider
      when 'github'
        repository.github_id
      end
    end
  end
end
