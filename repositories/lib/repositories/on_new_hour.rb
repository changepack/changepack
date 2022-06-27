# frozen_string_literal: true

module Repositories
  class OnNewHour < EventHandler
    subscribe Clock::NewHour

    def call
      Repository.active
                .pluck(:id)
                .map { |id| Repositories::Outdated.new(data: { repository_id: id }) }
                .each { |event| Event.publish(event) }
    end
  end
end
