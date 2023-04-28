# typed: false
# frozen_string_literal: true

class Repository
  class OnOutdated < Handler
    on ::Repository::Outdated

    sig { override.returns T::Boolean }
    def run
      repository.pull
    end

    private

    sig { returns Repository }
    def repository
      @repository ||= Repository.find(event.repository_id)
    end
  end
end
