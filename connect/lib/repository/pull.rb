# typed: false
# frozen_string_literal: true

class Repository
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

      sig { overridable.params(git: Provider).returns(T::Boolean) }
      def pull(git)
        transaction do
          git.repositories.each do |repository|
            Pull.upsert!(repository, git:)
          end
        end

        true
      end
    end

    sig { params(attributes: Hash, git: Provider).returns(Repository) }
    def self.upsert!(attributes, git:)
      providers = attributes.fetch(:providers)
      account_id = git.access_token.account_id

      Repository
        .lock
        .find_or_initialize_by(account_id:, providers:)
        .tap { |rep| rep.update!(attributes) }
    end

    sig { overridable.returns T::Boolean }
    def pull
      Commit.pull(self)
    end

    sig { overridable.returns T.nilable(Integer) }
    def cursor
      @cursor ||= commits.select { |commit| commit.commited_at > 1.month.ago }
                         .sort_by(&:commited_at)
                         .reverse
                         .pick(:commited_at)
                         .try(:to_i)
    end

    sig { overridable.returns Provider }
    def git
      @git ||= Provider[provider].new(access_token:)
    end
  end
end
