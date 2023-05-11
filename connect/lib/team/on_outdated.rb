# typed: false
# frozen_string_literal: true

class Team
  class OnOutdated < Handler
    on ::Team::Outdated

    sig { override.returns T::Boolean }
    def run
      team.pull
    end

    private

    sig { returns Team }
    def team
      @team ||= Team.find(event.team_id)
    end
  end
end
