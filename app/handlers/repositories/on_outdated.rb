# frozen_string_literal: true

module Repositories
  class OnOutdated < Handler
    on Outdated

    def run
      repository.pull
    end

    private

    def repository
      @repository ||= Repository.find(event.data.repository)
    end
  end
end
