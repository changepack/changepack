# typed: false
# frozen_string_literal: true

class Commit
  module Git
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    include Provided

    abstract!

    included do
      provider :github
    end

    class_methods do
      extend T::Sig

      sig { overridable.params(repository: Repository).returns(T::Boolean) }
      def pull(repository)
        transaction do
          source = Git.source(repository)
          ignore = repository.commits.pluck(:providers).map(&:values).flatten
          repository.git
                    .commits(source, after: repository.cursor)
                    .reject { |commit| ignore.include?(commit.sha) }
                    .each { |commit| Git.insert!(commit, repository:) }

          repository.update!(pulled_at: Time.current)
        end

        true
      end
    end

    sig { params(commit: Provider::Commit, repository: Repository).returns(Commit) }
    def self.insert!(commit, repository:)
      providers = { repository.provider => commit.sha }

      Commit.create!(
        commit.to_h.merge(repository:, providers:)
      )
    end

    sig { params(repository: Repository).returns(T.nilable(T::Integer)) }
    def self.source(repository)
      case repository.provider
      when 'github'
        repository.github
      end
    end
  end
end
