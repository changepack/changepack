# typed: false
# frozen_string_literal: true

module Repositories
  class OnNewHour < Handler
    on ::Clock::NewHour

    sig { override.returns T::String.array }
    def run
      Repository.active
                .pluck(:id)
                .map { |id| Repository::Outdated.new(repository_id: id) }
                .each { |event| Event.publish(event) }
    end
  end
end
