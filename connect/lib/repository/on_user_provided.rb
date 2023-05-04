# typed: false
# frozen_string_literal: true

class Repository
  class OnUserProvided < Handler
    on ::User::Provided

    sig { override.returns T::Boolean }
    def run
      Repository.pull(user.git)
    end

    sig { returns User }
    def user
      @user ||= User.find(event.id)
    end
  end
end
