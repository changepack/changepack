# frozen_string_literal: true

module Repositories
  include BoundedContext

  subscribe Commits::OnNewHour, to: Clock::NewHour

  class Pulled < Event
    attribute :id, Types::String
  end
end
