# typed: false
# frozen_string_literal: true

module Clock
  extend T::Sig

  class NewHour < Event
    attribute :hour, Integer
  end

  class NewDay < Event
    attribute :day, Integer
  end

  class HourlyTick < ApplicationJob
    sig { returns Integer }
    def perform
      Time.current.hour.tap do |hour|
        Event.publish(
          NewHour.new(hour:)
        )
      end
    end
  end

  class DailyTick < ApplicationJob
    sig { returns Integer }
    def perform
      Time.current.day.tap do |day|
        Event.publish(
          NewDay.new(day:)
        )
      end
    end
  end

  sig { returns Clock::HourlyTick }
  def self.hourly_tick
    HourlyTick.perform_later
  end

  sig { returns Clock::DailyTick }
  def self.daily_tick
    DailyTick.perform_later
  end
end
