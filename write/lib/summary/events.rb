# typed: false
# frozen_string_literal: true

class Summary
  module Events
    extend ActiveSupport::Concern

    class Requested < Event
      attribute :changelog_id, String
    end
  end
end
