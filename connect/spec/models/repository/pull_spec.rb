# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe Pull, :vcr do
    subject(:command) { Repository.pull(provider) }
    let(:provider) { user.provider(:github) }
    let(:user) { create(:user) }

    context 'with a GitHub integration' do
      let(:user) { create(:user, :github) }

      before { create(:access_token, :github, user:) }

      it 'upserts repositories' do
        expect { command }.to change(user.account.repositories, :count)
      end
    end
  end
end
