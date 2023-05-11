# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Team
  describe OnUserProvidersChanged do
    let(:user) { create(:user, :linear) }
    let(:payload) do
      {
        event_type: 'User::ProvidersChanged',
        data: {
          id: user.id,
          provider: 'linear',
          providers: user.providers
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'pulls teams' do
      allow(Team).to receive(:pull).and_return(true)

      handler.perform(payload)

      expect(Team).to have_received(:pull)
    end
  end
end
