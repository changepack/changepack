# frozen_string_literal: true

module Clock
  class Tick < ApplicationJob
    def perform
      Time.current.hour.tap do |hour|
        Event.publish(
          NewHour.new(data: { hour: })
        )
      end
    end
  end
end