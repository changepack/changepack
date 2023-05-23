# typed: false
# frozen_string_literal: true

class Commit
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    module Resource
      include ::Resource

      included do
        attribute :id, String
        attribute :account_id, String
        attribute :repository_id, String
        attribute :message, String
        attribute :author, Hash
        attribute :commited_at, T::Time
      end

      sig { params(commit: Commit).returns Hash }
      def self.to_event(commit)
        commit
          .as_json(only: %i[id account_id repository_id message author])
          .symbolize_keys
          .merge(commited_at: commit.created_at)
      end
    end

    class Created < Event
      include Resource
    end
  end
end
