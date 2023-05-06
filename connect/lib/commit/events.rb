# typed: false
# frozen_string_literal: true

class Commit
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Created < Event
      attribute :id, String
      attribute :account_id, String
      attribute :repository_id, String
      attribute :message, String
      attribute :author, Hash
    end
  end
end
