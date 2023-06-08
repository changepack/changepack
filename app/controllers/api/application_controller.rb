# typed: false
# frozen_string_literal: true

module API
  class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Pagy::Backend

    extend T::Sig

    attr_reader :current_api_key, :current_bearer
    # Accessor for validation results hash
    attr_reader :validation_result

    # Schema assigned on a class level
    class_attribute :schema

    before_action :set_paper_trail_whodunnit
    before_action :authenticate_bearer!
    before_action :set_raven_context
    # Make sure that request data meets schema requirements
    before_action :ensure_schema!

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    private

    attr_writer :current_api_key, :current_bearer

    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end

    # Use this to raise an error and automatically respond with a 401 HTTP status
    # code when API key authentication fails
    sig { returns T.nilable(API::Bearer) }
    def authenticate_bearer!
      @current_bearer = authenticate_or_request_with_http_token { |token, options| authenticator(token, options) }
    end

    # Use this for optional API key authentication
    sig { returns T.nilable(API::Bearer) }
    def authenticate_bearer
      @current_bearer = authenticate_with_http_token { |token, options| authenticator(token, options) }
    end

    sig { returns T.nilable(bearer_type: String, bearer_id: String) }
    def set_raven_context
      Sentry.set_user(bearer_type: current_bearer.class.name, bearer_id: current_bearer.id) if current_bearer.present?
    end

    def ensure_schema!
      return if self.class.schema.blank?

      @validation_result = self.class.schema.new.call(params.permit!.to_h)
      return if @validation_result.success?

      render json: @validation_result.errors.to_json, status: :unprocessable_entity
    end

    sig { params(http_token: String, _options: T.untyped).returns T.nilable(API::Bearer) }
    def authenticator(http_token, _options)
      @current_api_key = API::Key.find_by(token: http_token)

      current_api_key.try(:update, last_used_at: Time.zone.now)
      current_api_key.try(:bearer)
    end
  end
end
