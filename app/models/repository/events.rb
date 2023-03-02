# frozen_string_literal: true

class Repository
  module Events
    extend ActiveSupport::Concern

    class Outdated < Event
      attribute :repository, Types::String
    end

    class Authorized < Event
      attribute :user, Types::String
    end
  end
end
