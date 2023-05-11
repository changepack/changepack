# typed: false
# frozen_string_literal: true

class Team
  class OnNewHour < Handler
    on ::Clock::NewHour

    sig { override.returns T::Array[String] }
    def run
      Team.active
          .pluck(:id)
          .map { |id| Team::Outdated.new(team_id: id) }
          .each { |event| Event.publish(event) }
    end
  end
end
