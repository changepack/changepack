# typed: false
# frozen_string_literal: true

class Source
  class OnTeamCreated < Handler
    on ::Team::Created

    delegate :account_id, :name, :status, to: :event
    delegate :id, to: :event, prefix: :team

    sig { override.returns Source }
    def run
      Source.create(
        type: :team,
        account_id:,
        newsletter:,
        team_id:,
        status:,
        name:
      )
    end

    sig { returns Newsletter }
    def newsletter
      @newsletter ||= Account.find(account_id).newsletters.first
    end
  end
end
