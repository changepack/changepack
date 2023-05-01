# typed: false
# frozen_string_literal: true

class Changelog
  class OnNewDay < Handler
    on ::Clock::NewDay

    sig { override.returns T::Array[String] }
    def run
      return [] if event.day > 1

      Changelog.pluck(:id).each do |changelog_id|
        Event.publish(
          Changelog::MonthlyUpdateRequested.new(changelog_id:)
        )
      end
    end
  end
end
