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
        changelog:,
        team_id:,
        status:,
        name:
      )
    end

    sig { returns Changelog }
    def changelog
      @changelog ||= Account.find(account_id).changelogs.first
    end
  end
end
