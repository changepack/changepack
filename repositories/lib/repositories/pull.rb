# frozen_string_literal: true

module Repositories
  class Pull < Command
    self.transaction = false

    params user: Types::Instance(User)

    def perform
      github.perform if github.valid?
    end

    private

    def github
      @github ||= ::Repositories::Github::Pull.new(user:)
    end

    delegate :user, to: :params
  end
end
