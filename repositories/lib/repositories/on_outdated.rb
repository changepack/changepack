# frozen_string_literal: true

module Repositories
  class OnOutdated < EventHandler
    subscribe Outdated

    def call
      Commits::Pull.new(repository:).execute
    end

    private

    def repository
      Repository.find(event.repository_id)
    end
  end
end
