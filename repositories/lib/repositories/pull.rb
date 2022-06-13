# frozen_string_literal: true

module Repositories
  class Pull < Command
    self.transaction = false

    option :user, model: User

    def perform
      github.perform if github.valid?
    end

    private

    def github
      @github ||= ::Repositories::GitHub::Pull.new(user:)
    end
  end
end
