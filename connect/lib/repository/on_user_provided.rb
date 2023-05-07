# typed: false
# frozen_string_literal: true

class Repository
  class OnUserProvided < Handler
    on ::User::Provided

    sig { override.returns T::Boolean }
    def run
      return false if bad_provider?

      Repository.pull(user.git)
    end

    sig { returns User }
    def user
      @user ||= User.find(event.id)
    end

    def bad_provider?
      !event.provider.to_sym.in?(providers)
    end

    sig { returns T::Array[T::Symbol] }
    def providers
      [:github]
    end
  end
end
