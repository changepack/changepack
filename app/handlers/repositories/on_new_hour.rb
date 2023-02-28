# frozen_string_literal: true

module Repositories
  class OnNewHour < EventHandler
    on Clock::NewHour

    def run
      Repository.active
                .pluck(:id)
                .map { |id| Repository::Outdated.new(data: { repository: id }) }
                .each { |event| Event.publish(event) }
    end
  end
end
