# frozen_string_literal: true

require 'rails_helper'

class Repository
  describe Git, :vcr do
    subject(:command) { Repository.pull(user.git, account: user.account) }
    let(:user) { create(:user) }

    context 'with a GitHub integration' do
      context 'without a token' do
        it "doesn't execute" do
          expect { command }.not_to change(user.account.repositories, :count)
        end
      end

      context 'with a token' do
        let(:user) { create(:user, providers: { github: { access_token: 'access_token' } }) }

        it 'upserts repositories' do
          expect { command }.to change(user.account.repositories, :count)
        end
      end
    end
  end
end
