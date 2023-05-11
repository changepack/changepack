# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Team
  describe Pull, :vcr do
    subject(:command) { Team.pull(provider) }
    let(:provider) { user.access_token(:linear).provider }
    let(:user) { create(:user) }

    context 'with a Linear integration' do
      let(:user) { create(:user, :linear) }

      it 'upserts teams' do
        expect { command }.to change(user.account.teams, :count)
      end
    end
  end
end
