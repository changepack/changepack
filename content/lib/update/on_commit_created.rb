# typed: false
# frozen_string_literal: true

class Update
  class OnCommitCreated < Handler
    on ::Commit::Created

    sig { override.returns Update }
    def run
      Update.create!(
        type: :commit,
        account_id: event.account_id,
        commit_id: event.id,
        name: event.message,
        source:
      )
    end

    sig { returns T.nilable(Source) }
    def source
      @source ||= Source.find_by(repository_id: event.repository_id)
    end
  end
end
