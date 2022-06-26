# frozen_string_literal: true

module Repositories
  class Outdated < Event
    attribute :repository_id, Types::String
  end
end
