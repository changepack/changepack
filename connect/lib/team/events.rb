# typed: false
# frozen_string_literal: true

class Team
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Outdated < Event
      attribute :team_id, String
    end

    module Resource
      include ::Resource

      included do
        attribute :id, String
        attribute :account_id, String
        attribute :name, String
        attribute :status, String
      end

      sig { params(team: Team).returns Hash }
      def self.to_event(team)
        team
          .as_json(only: %i[id account_id name status])
          .symbolize_keys
          .transform_values(&:to_s)
      end
    end

    class Created < Event
      include Resource
    end

    class Updated < Event
      include Resource
    end

    class Destroyed < Event
      include Resource
    end
  end
end
