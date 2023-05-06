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

    class Authorized < Event
      attribute :provider, T::Key
      attribute :access_token, String
      attribute :account_id, String
    end

    class Created < Event
      attribute :id, String
      attribute :account_id, String
      attribute :name, String
      attribute :status, String
    end

    class Updated < Event
      attribute :id, String
      attribute :account_id, String
      attribute :name, String
      attribute :status, String
    end

    class Destroyed < Event
      attribute :id, String
    end
  end
end
