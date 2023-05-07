# typed: false
# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      register_or_sign_in_from!(:github)
      redirect_to sources_path, notice: t('devise.omniauth_callbacks.success', kind: 'GitHub')
    end

    def linear
      register_or_sign_in_from!(:linear)
      redirect_to sources_path, notice: t('devise.omniauth_callbacks.success', kind: 'Linear')
    end

    private

    sig { params(provider: Symbol).returns(T::Boolean) }
    def register_or_sign_in_from!(provider)
      if user_signed_out?
        User.register!(provider, auth).tap { |user| sign_in(user) }
      else
        current_user.register!(provider, auth)
      end

      true
    end

    sig { returns OmniAuth::AuthHash }
    def auth
      request.env['omniauth.auth']
    end

    sig { returns String }
    def after_omniauth_failure_path_for(_)
      root_path
    end
  end
end
