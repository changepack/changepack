# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :authenticate_user!

    def github
      current_user.lock!
      current_user.provider_ids.deep_merge!(github: github_ids)
      current_user.save!

      redirect_to root_path, notice: t('devise.omniauth_callbacks.success', kind: 'GitHub')
    end

    private

    def github_ids
      {
        id: auth.uid,
        access_token: auth.credentials.token
      }
    end

    def auth
      request.env['omniauth.auth']
    end

    def after_omniauth_failure_path_for(_)
      root_path
    end
  end
end
