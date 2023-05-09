# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe Git, :vcr do
    subject(:command) { Repository.pull(provider) }
    let(:provider) { user.provider(:github) }
    let(:user) { create(:user) }

    context 'with a GitHub integration' do
      let(:user) { create(:user, providers: { github: 1 }) }

      before { create(:access_token, user:) }

      it 'upserts repositories' do
        expect { command }.to change(user.account.repositories, :count)
      end
    end
  end
end
