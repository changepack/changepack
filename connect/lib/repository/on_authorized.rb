# typed: false
# frozen_string_literal: true

class Repository
  class OnAuthorized < Handler
    on ::Repository::Authorized

    sig { override.returns T::Boolean }
    def run
      Repository.pull(git)
    end

    private

    delegate :provider, :access_token, :account_id, to: :event

    sig { returns Provider }
    def git
      @git ||= Provider[provider].new(access_token:, account_id:)
    end
  end
end
