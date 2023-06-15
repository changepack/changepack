# typed: false
# frozen_string_literal: true

class Issue
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

      sig { overridable.params(team: Team).returns(T::Boolean) }
      def pull(team)
        transaction do
          team.app
              .issues(team, after: team.cursor)
              .each { |issue| Pull.upsert!(issue, team:) }

          team.update!(pulled_at: Time.current)
        end

        true
      end
    end

    sig { params(attributes: Hash, team: Team).returns(Issue) }
    def self.upsert!(attributes, team:)
      providers = attributes.fetch(:providers)
      team_id = team.id

      Issue
        .lock
        .find_or_initialize_by(team_id:, providers:)
        .tap { |issue| issue.update!(attributes) }
    end
  end
end
