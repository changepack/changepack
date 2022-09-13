# frozen_string_literal: true

module Repositories
  class Outdated < Event
    attribute :repository, Types::String
  end

  class Authorized < Event
    attribute :user, Types::String
  end
end
