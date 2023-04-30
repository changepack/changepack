# typed: false
# frozen_string_literal: true

class Source
  class OnRepositoryUpdated < Handler
    on ::Repository::Updated

    delegate :account_id, :name, :status, to: :event
    delegate :id, to: :event, prefix: :repository

    sig { override.returns T::Boolean }
    def run
      source&.update!(
        repository_id:,
        account_id:,
        status:,
        name:
      )
    end

    def source
      @source ||= Source.find_by(repository_id: event.id)
    end
  end
end
