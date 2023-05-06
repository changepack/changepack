# typed: false
# frozen_string_literal: true

class Source
  class OnTeamDestroyed < Handler
    on ::Team::Destroyed

    sig { override.returns T.nilable(Source) }
    def run
      Source.find_by(team_id: event.id).try(:destroy)
    end
  end
end
