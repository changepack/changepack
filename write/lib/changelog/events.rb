# typed: false
# frozen_string_literal: true

class Changelog
  module Events
    extend ActiveSupport::Concern

    class MonthlyUpdateRequested < Event
      attribute :changelog_id, String
    end
  end
end
