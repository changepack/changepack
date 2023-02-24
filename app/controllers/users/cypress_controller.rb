# frozen_string_literal: true

module Users
  class CypressController < ApplicationController
    skip_before_action :verify_authenticity_token, :authenticate_user!

    def authenticate
      return unless Rails.env.test?

      sign_in(user)
      redirect_to URI.parse(params.require(:redirect_to)).path
    end

    private

    def user
      @user ||= if params[:email].present?
                  User.find_by!(email: params.require(:email))
                else
                  User.first!
                end
    end
  end
end
