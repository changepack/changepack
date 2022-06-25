# frozen_string_literal: true

require 'rails_helper'

module Commits
  describe Pull, :vcr do
    subject(:operation) { described_class.new(repository:) }
    let(:user) { create(:user) }
    let(:repository) { create(:repository, user:, account: user.account) }

    context 'with a GitHub integration' do
      context 'without a token' do
        it "doesn't execute" do
          expect { operation.execute }.to raise_error Commits::Pull::Disconnected
        end
      end

      context 'with a token' do
        let(:user) { create(:user, provider_ids: { github: { access_token: 'access_token' } }) }

        it 'upserts repositories' do
          expect { operation.execute }.to change(repository.commits, :count)
        end
      end
    end
  end
end
