# typed: false
# frozen_string_literal: true

class Team
  class OnUserProvidersChanged < Handler
    on ::User::ProvidersChanged

    sig { override.returns T::Boolean }
    def run
      return false if bad_provider?

      Team.pull(provider)
    end

    sig { returns Provider }
    def provider
      @provider ||= user.access_token(:linear).provider
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
      [:linear]
    end
  end
end
