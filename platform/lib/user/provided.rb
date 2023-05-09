# typed: false
# frozen_string_literal: true

class User
  module Provided
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    include ::Provided

    abstract!

    included do
      provider :github
      provider :linear
    end

    sig { overridable.params(name: T::Key).returns T.nilable(Provider) }
    def provider(name)
      return if providers.blank?

      @provider ||= {}
      @provider[name] ||= Provider[name].new access_token: access_token(name)
    end

    sig { overridable.params(name: T::Key).returns T.nilable(AccessToken) }
    def access_token(name)
      @access_token ||= access_tokens.find { |token| token.provider.to_sym == name }
    end
  end
end
