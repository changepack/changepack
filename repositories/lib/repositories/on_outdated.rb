# frozen_string_literal: true

module Repositories
  class OnOutdated < EventHandler
    subscribe Outdated

    def call
      Commits::Pull.run(repository:)
    end

    private

    def repository
      Repository.find(event.data.repository)
    end
  end
end
