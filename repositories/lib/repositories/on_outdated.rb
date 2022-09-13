# frozen_string_literal: true

module Repositories
  class OnOutdated < EventHandler
    on Outdated

    def run
      Commits::Pull.run(repository:)
    end

    private

    def repository
      Repository.find(event.data.repository)
    end
  end
end
