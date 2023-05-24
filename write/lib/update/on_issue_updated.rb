# typed: false
# frozen_string_literal: true

class Update
  class OnIssueUpdated < Handler
    on ::Issue::Updated

    delegate :id, to: :event, prefix: :issue
    delegate :done, to: :event

    sig { override.returns Update }
    def run
      update = Update.find_by(issue_id:)
      update.undiscard if done?(update)
      update
    end

    private

    sig { params(update: Update).returns(T::Boolean) }
    def done?(update)
      update&.discarded? && done.present?
    end
  end
end
