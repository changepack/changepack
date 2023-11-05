# typed: false
# frozen_string_literal: true

class Summary
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Requested < Event
      attribute :newsletter_id, String
    end
  end
end
