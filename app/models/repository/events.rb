# frozen_string_literal: true

class Repository
  module Events
    extend ActiveSupport::Concern

    class Outdated < Event
      attribute :repository_id, Types::String
    end

    class Authorized < Event
      attribute :provider, Types::Coercible::String
      attribute :access_token, Types::String
      attribute :account_id, Types::String
    end
  end
end
