# typed: false
# frozen_string_literal: true

module Changes
  class OnCommitCreated < Handler
    on ::Commit::Created

    delegate :account_id, :message, to: :event
    delegate :id, to: :event, prefix: :commit

    sig { override.returns Change }
    def run
      Change.create(
        type: :commit,
        account_id:,
        commit_id:,
        message:
      )
    end
  end
end
