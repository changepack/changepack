# frozen_string_literal: true

module Commits
  class Pull < Command
    self.transaction = false

    option :repository, model: Repository

    def perform
      github.perform if github.valid?
    end

    private

    def github
      @github ||= ::Commits::GitHub::Pull.new(repository:)
    end
  end
end
