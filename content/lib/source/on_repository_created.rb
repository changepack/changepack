# typed: false
# frozen_string_literal: true

class Source
  class OnRepositoryCreated < Handler
    on ::Repository::Created

    delegate :account_id, :name, :status, to: :event
    delegate :id, to: :event, prefix: :repository

    sig { override.returns Source }
    def run
      Source.create!(
        type: :repository,
        repository_id:,
        account_id:,
        changelog:,
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
