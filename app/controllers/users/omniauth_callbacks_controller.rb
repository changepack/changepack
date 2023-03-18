# typed: false
# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      sign_in_from!(:github)
      redirect_to repositories_path, notice: t('devise.omniauth_callbacks.success', kind: 'GitHub')
    end

    private

    def sign_in_from!(provider)
      if user_signed_out?
        User.from!(provider, auth).tap { |user| sign_in(user) }
      else
        provider = User.provider(provider, auth)
        providers = current_user.providers.deep_merge!(provider)

        current_user.lock!
                    .update!(providers:)
      end

      Repository.pull_async(current_user.git)
    end

    def auth
      request.env['omniauth.auth']
    end

    def after_omniauth_failure_path_for(_)
      root_path
    end
  end
end
