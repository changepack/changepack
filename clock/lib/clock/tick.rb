# frozen_string_literal: true

module Clock
  class Tick < ApplicationJob
    def perform
      Event.publish(
        NewHour.new(hour: Time.current.hour)
      )
    end
  end
end
