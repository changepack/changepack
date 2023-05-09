# typed: false
# frozen_string_literal: true

class Repository
  class OnUserProvidersChanged < Handler
    on ::User::ProvidersChanged

    sig { override.returns T::Boolean }
    def run
      return false if bad_provider?

      Repository.pull(provider)
    end

    sig { returns Provider }
    def provider
      @provider ||= user.access_token(:github).provider
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
