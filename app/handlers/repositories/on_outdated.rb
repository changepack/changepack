# typed: false
# frozen_string_literal: true

module Repositories
  class OnOutdated < Handler
    on ::Repository::Outdated

    sig { returns T::Boolean }
    def run
      repository.pull
    end

    private

    sig { returns Repository }
    def repository
      @repository ||= Repository.find(event.data.repository_id)
    end
  end
end
