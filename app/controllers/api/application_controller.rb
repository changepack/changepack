# typed: false
# frozen_string_literal: true

module API
  class ApplicationController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods

    attr_reader :current_api_key
    attr_reader :current_bearer

    skip_before_action :verify_authenticity_token, :authenticate_user!
    skip_verify_authorized

    before_action :authenticate_bearer!

    # Use this to raise an error and automatically respond with a 401 HTTP status
    # code when API key authentication fails
    def authenticate_bearer!
      @current_bearer = authenticate_or_request_with_http_token { |token, options| authenticator(token, options) }
    end

    # Use this for optional API key authentication
    def authenticate_bearer
      @current_bearer = authenticate_with_http_token { |token, options| authenticator(token, options) }
    end

    private

    attr_writer :current_api_key, :current_bearer

    def authenticator(http_token, _options)
      @current_api_key = API::Key.find_by(token: http_token)

      current_api_key.try(:update, last_used_at: Time.zone.now)
      current_api_key.try(:bearer)
    end
  end
end
