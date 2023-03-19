# typed: false
# frozen_string_literal: true

module Repositories
  class OnNewHour < Handler
    on ::Clock::NewHour

    sig { returns T::Array[T::String] }
    def run
      Repository.active
                .pluck(:id)
                .map { |id| Repository::Outdated.new(data: { repository_id: id }) }
                .each { |event| Event.publish(event) }
    end
  end
end
