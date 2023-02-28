# frozen_string_literal: true

class Repository
  module Git
    extend ActiveSupport::Concern

    include Provider
    include Pull

    included do
      provider :github, :id
      provider :github, :access_token
    end

    def git
      return if providers.blank?

      @git ||= Adapters[provider].new(access_token)
    end

    def access_token
      providers.dig(provider, :access_token)
    end
  end
end
