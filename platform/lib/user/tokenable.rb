# typed: false
# frozen_string_literal: true

class User
  module Tokenable
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    include Provided

    abstract!

    included do
      provider :github
      provider :linear
    end

    sig { overridable.params(name: T::Key).returns T.nilable(AccessToken) }
    def access_token(name)
      @access_token ||= access_tokens.find { |token| token.type.to_sym == name }
    end
  end
end
