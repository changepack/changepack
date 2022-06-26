# frozen_string_literal: true

module Clock
  class NewHour < Event
    attribute :hour, Types::Integer
  end
end
