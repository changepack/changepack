# typed: false
# frozen_string_literal: true

class Issue
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Created < Event
      attribute :id, String
      attribute :account_id, String
      attribute :team_id, String
      attribute :title, String
    end

    class Updated < Event
      attribute :id, String
      attribute :account_id, String
      attribute :team_id, String
      attribute :title, String
    end

    class Destroyed < Event
      attribute :id, String
    end
  end
end
