# typed: false
# frozen_string_literal: true

class Commit
  module Pull
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
          source = Pull.source(repository)
          repository.git
                    .commits(source, after: repository.cursor)
                    .each { |commit| Pull.upsert!(commit, repository:) }

          repository.update!(pulled_at: Time.current)
        end

        true
      end
    end

    sig { params(attributes: Hash, repository: Repository).returns(Commit) }
    def self.upsert!(attributes, repository:)
      providers = attributes.fetch(:providers)
      repository_id = repository.id

      Commit
        .lock
        .find_or_initialize_by(repository_id:, providers:)
        .tap { |commit| commit.update!(attributes) }
    end

    sig { params(repository: Repository).returns T.nilable(T::Integer) }
    def self.source(repository)
      case repository.provider
      when 'github'
        repository.github
      end
    end
  end
end
