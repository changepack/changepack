# typed: false
# frozen_string_literal: true

module Users
  class CypressController < ApplicationController
    skip_before_action :verify_authenticity_token, :authenticate_user!

    def authenticate
      return unless Rails.env.test?

      sign_in(user)
      redirect_to path
    end

    private

    def user
      User.find_by(email:)
    end

    def email
      params.require(:email)
    end

    def path
      params.require(:redirect_to)
            .then { |path| URI.parse(path).path }
    end
  end
end
