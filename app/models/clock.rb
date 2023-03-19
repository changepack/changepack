# typed: false
# frozen_string_literal: true

module Clock
  extend T::Sig

  class NewHour < Event
    attribute :hour, Integer
  end

  class Tick < ApplicationJob
    sig { returns T::Integer }
    def perform
      Time.current.hour.tap do |hour|
        Event.publish(
          NewHour.new(hour:)
        )
      end
    end
  end

  sig { returns Clock::Tick }
  def self.tick
    Tick.perform_later
  end
end
