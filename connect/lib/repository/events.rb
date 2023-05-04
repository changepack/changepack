# typed: false
# frozen_string_literal: true

class Repository
  module Events
    extend ActiveSupport::Concern

    class Outdated < Event
      attribute :repository_id, String
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
