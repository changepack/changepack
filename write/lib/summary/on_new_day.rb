# typed: false
# frozen_string_literal: true

class Summary
  class OnNewDay < Handler
    on ::Clock::NewDay

    sig { override.returns T::Array[Event] }
    def run
      Newsletter.pluck(:id)
                .select { event.day > 1 }
                .map { |newsletter_id| Summary::Requested.new(newsletter_id:) }
                .each { |event| Event.publish(event) }
    end
  end
end
