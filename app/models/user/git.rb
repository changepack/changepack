# typed: false
# frozen_string_literal: true

class User
  module Git
    extend ActiveSupport::Concern
    extend T::Sig

    include Provided

    included do
      provider :github
      provider :github, :id
      provider :github, :access_token
    end

    sig { returns T.nilable(Provider) }
    def git
      return if providers.blank?

      @git ||= Provider[provider].new(access_token:, account_id:)
    end

    sig { returns String }
    def access_token
      providers.dig(provider, :access_token)
    end

    sig { returns T::Boolean }
    def git?
      providers.present?
    end
  end
end
