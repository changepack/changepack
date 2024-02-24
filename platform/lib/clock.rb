# typed: false
# frozen_string_literal: true

module Clock
  extend T::Sig

  class NewHour < Event
    attribute :hour, Integer
    attribute :date, Date
  end

  class NewDay < Event
    attribute :date, Date
  end

  class HourlyTick < ApplicationJob
    sig { returns Time }
    def perform
      Time.current.tap { |time| Event.publish NewHour.new(hour: time.hour, date: time.to_date) }
    end
  end

  class DailyTick < ApplicationJob
    sig { returns Integer }
    def perform
      Event.publish NewDay.new(date: Date.current)
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
