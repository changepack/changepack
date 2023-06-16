# typed: false
# frozen_string_literal: true

class Update
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    class Upserted < Event
      attribute :id, String
    end
  end
end
