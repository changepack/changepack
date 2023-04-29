# typed: false
# frozen_string_literal: true

class Source
  class OnRepositoryCreated < Handler
    on ::Repository::Created

    delegate :account_id, :name, to: :event
    delegate :id, to: :event, prefix: :repository

    sig { override.returns Source }
    def run
      Source.create(
        type: :repository,
        account_id:,
        repository_id:,
        name:
      )
    end
  end
end
