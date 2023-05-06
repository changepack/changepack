# typed: false
# frozen_string_literal: true

class Issue
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    module Resource
      include ::Resource

      included do
        attribute :id, String
        attribute :account_id, String
        attribute :team_id, String
        attribute :title, String
        attribute :assignee, Hash
      end

      sig { params(issue: Issue).returns Hash }
      def self.to_event(issue)
        issue
          .as_json(only: %i[id account_id team_id title assignee])
          .symbolize_keys
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
