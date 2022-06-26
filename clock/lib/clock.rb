# frozen_string_literal: true

module Clock
  include BoundedContext

  class NewHour < Event
    attribute :hour, Types::Integer
  end
end
