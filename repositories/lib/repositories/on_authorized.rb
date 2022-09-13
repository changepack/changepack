# frozen_string_literal: true

module Repositories
  class OnAuthorized < EventHandler
    subscribe Authorized

    def call
      Repositories::Pull.new(user:).execute
    end

    private

    def user
      User.find(event.data.user)
    end
  end
end
