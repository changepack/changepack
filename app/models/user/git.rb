# frozen_string_literal: true

class User
  module Git
    extend ActiveSupport::Concern

    include Provided

    included do
      provider :github
    end

    def git
      return if providers.blank?

      @git ||= Provider[provider].new(access_token)
    end

    def access_token
      providers.dig(provider, :access_token)
    end

    def git?
      providers.present?
    end
  end
end
