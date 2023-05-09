# typed: false
# frozen_string_literal: true

require 'rails_helper'

module Users
  describe OmniauthCallbacksController do
    let(:user) { create(:user) }
    let(:result) { { provider.to_s => 'id' } }

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
        provider:,
        uid: 'id',
        credentials: {
          token: 'access_token'
        }
      )

      sign_in(user)
    end

    context 'when GitHub is used' do
      let(:provider) { :github }

      it 'saves credentials to GitHub' do
        expect { get '/users/auth/github/callback' }.to change(user, :providers).from({}).to(result)
      end

      it 'saves access token' do
        expect { get '/users/auth/github/callback' }.to change(user.access_tokens, :count).by(1)
      end

      it 'sends an event to pull repositories' do
        expect { get '/users/auth/github/callback' }.to publish(
          an_event(User::ProvidersChanged)
        ).in(Rails.configuration.event_store)
      end
    end

    context 'when Linear is used' do
      let(:provider) { :linear }

      it 'saves credentials to GitHub' do
        expect { get '/users/auth/linear/callback' }.to change(user, :providers).from({}).to(result)
      end

      it 'saves access token' do
        expect { get '/users/auth/linear/callback' }.to change(user.access_tokens, :count).by(1)
      end

      it 'sends an event to pull repositories' do
        expect { get '/users/auth/linear/callback' }.to publish(
          an_event(User::ProvidersChanged)
        ).in(Rails.configuration.event_store)
      end
    end
  end
end
