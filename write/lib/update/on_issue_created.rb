# typed: false
# frozen_string_literal: true

class Update
  class OnIssueCreated < Handler
    on ::Issue::Created

    delegate :account_id, :title, :assignee, :team_id, :issued_at, to: :event
    delegate :id, to: :event, prefix: :issue

    sig { override.returns Update }
    def run
      Update.create(
        sourced_at: issued_at,
        type: :issue,
        name: title,
        account_id:,
        changelog:,
        issue_id:,
        source:,
        tags:
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

    sig { returns T::Array[String] }
    def tags
      [
        assignee.try(:fetch, :email)
      ].compact
    end
  end
end
