# typed: false
# frozen_string_literal: true

class Update
  class OnIssueCreated < Handler
    on ::Issue::Created

    delegate :account_id, :title, :assignee, :team_id, to: :event
    delegate :id, to: :event, prefix: :issue

    sig { override.returns Update }
    def run
      Update.create(
        email: assignee.fetch(:email),
        type: :issue,
        name: title,
        account_id:,
        changelog:,
        issue_id:,
        source:
      )
    end

    sig { returns T.nilable(Source) }
    def source
      @source ||= Source.find_by(team_id:)
    end

    sig { returns Changelog }
    def changelog
      @changelog ||= Account.find(account_id).changelogs.first
    end
  end
end
