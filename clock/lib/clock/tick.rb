# frozen_string_literal: true

module Clock
  class Tick < ApplicationJob
    def perform
      NewHour.new(hour: Time.current.hour).publish
    end
  end
end
