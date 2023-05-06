# typed: false
# frozen_string_literal: true

class Repository
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Outdated < Event
      attribute :repository_id, String
    end

    module Resource
      include ::Resource

      included do
        attribute :id, String
        attribute :account_id, String
        attribute :name, String
        attribute :status, String
      end

      sig { params(repository: Repository).returns Hash }
      def self.to_event(repository)
        repository
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
