# frozen_string_literal: true

module Repositories
  include BoundedContext

  class Outdated < Event
    attribute :repository_id, Types::String
  end

  subscribe OnNewHour, to: Clock::NewHour
  subscribe OnOutdated, to: Outdated
end
