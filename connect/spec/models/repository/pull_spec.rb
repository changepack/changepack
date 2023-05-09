# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe Pull, :vcr do
    subject(:command) { Repository.pull(provider) }
    let(:provider) { user.access_token(:github).provider }
    let(:user) { create(:user) }

    context 'with a GitHub integration' do
      let(:user) { create(:user, :github) }

      it 'upserts repositories' do
        expect { command }.to change(user.account.repositories, :count)
      end
    end
  end
end
