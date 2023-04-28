# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe Git, :vcr do
    subject(:command) { Repository.pull(user.git) }
    let(:user) { create(:user) }

    context 'with a GitHub integration' do
      let(:user) { create(:user, providers: { github: { access_token: 'access_token' } }) }

      it 'upserts repositories' do
        expect { command }.to change(user.account.repositories, :count)
      end
    end
  end
end
