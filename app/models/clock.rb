# frozen_string_literal: true

module Clock
  class NewHour < Event
    attribute :hour, Types::Integer
  end

  class Tick < ApplicationJob
    def perform
      Time.current.hour.tap do |hour|
        Event.publish(
          NewHour.new(data: { hour: })
        )
      end
    end
  end

  def self.tick
    Tick.perform_later
  end
end
