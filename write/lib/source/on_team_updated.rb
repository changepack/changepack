# typed: false
# frozen_string_literal: true

class Source
  class OnTeamUpdated < Handler
    on ::Team::Updated

    delegate :account_id, :name, :status, to: :event
    delegate :id, to: :event, prefix: :team

    sig { override.returns T::Boolean }
    def run
      return false if source.blank?

      source.update!(
        account_id:,
        team_id:,
        status:,
        name:
      )
    end

    sig { returns T.nilable(Source) }
    def source
      @source ||= Source.find_by(team_id:)
    end
  end
end
