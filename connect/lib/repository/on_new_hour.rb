# typed: false
# frozen_string_literal: true

class Repository
  class OnNewHour < Handler
    on ::Clock::NewHour

    sig { override.returns T::Array[String] }
    def run
      Repository.active
                .pluck(:id)
                .map { |id| Repository::Outdated.new(repository_id: id) }
                .each { |event| Event.publish(event) }
    end
  end
end
