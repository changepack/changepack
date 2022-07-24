# frozen_string_literal: true

require 'rails_helper'

module Users
  describe OmniauthCallbacksController, type: :request do
    let(:user) { create(:user) }
    let(:result) do
      {
        'github' => {
          'id' => 'id',
          'access_token' => 'access_token'
        }
      }
    end

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: :github,
        uid: 'id',
        credentials: {
          token: 'access_token'
        }
      )

      sign_in(user)
    end

    it 'saves credentials to GitHub' do
      expect { get '/users/auth/github/callback' }.to change(user, :providers).from({}).to(result)
    end

    it 'sends an event to pull repositories' do
      expect { get '/users/auth/github/callback' }.to publish(
        an_event(Repositories::Authorized)
      ).in(Rails.configuration.event_store)
    end
  end
end
