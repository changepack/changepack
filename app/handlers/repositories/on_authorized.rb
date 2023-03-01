# frozen_string_literal: true

module Repositories
  class OnAuthorized < Handler
    on Repository::Authorized

    def run
      Repository.pull(git, account:)
    end

    private

    delegate :git, :account, to: :user

    def user
      @user ||= User.find(event.data.user)
    end
  end
end
