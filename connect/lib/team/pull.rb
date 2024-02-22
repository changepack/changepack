# typed: false
# frozen_string_literal: true

class Team
  module Pull
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    include Provided

    abstract!

    included do
      provider :linear
    end

    class_methods do
      extend T::Sig

      sig { overridable.params(app: Provider).returns(T::Boolean) }
      def pull(app)
        transaction do
          app.teams.each do |team|
            Pull.upsert!(team, app:)
          end
        end

        true
      end
    end

    sig { params(attributes: Hash, app: Provider).returns(Team) }
    def self.upsert!(attributes, app:)
      access_token = app.access_token
      account_id = access_token.account_id
      providers = attributes.fetch(:providers)

      Team
        .lock
        .find_or_initialize_by(account_id:, access_token:, providers:)
        .tap { |team| team.update!(attributes) }
    end

    sig { overridable.returns T::Boolean }
    def pull
      Issue.pull(self)
    end

    sig { overridable.returns T.nilable(String) }
    def cursor
      @cursor ||= issues.sort_by(&:issued_at)
                        .reverse
                        .last(100)
                        .last&.linear
    end

    sig { overridable.returns Provider }
    def app
      @app ||= Provider[provider].new(access_token:)
    end
  end
end
