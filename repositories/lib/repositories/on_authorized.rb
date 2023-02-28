# frozen_string_literal: true

module Repositories
  class OnAuthorized < EventHandler
    on Authorized

    def run
      Repository.pull(user.git, account: user.account)
    end

    private

    def user
      User.find(event.data.user)
    end
  end
end
